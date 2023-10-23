import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:museum_app/models/exhibit.dart';

class ExhibitApi {
  var baseUrl = '10.0.2.2:80';

  Future<List<Exhibit>?> getExhibits() async {
    try {
      var url = Uri.http(baseUrl, 'exhibits');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        print('WE HAVE DATAAAAAAAA');

        var items = jsonDecode(response.body)['exhibits'];

        List<Exhibit> exhibits =
            items.map((item) => Exhibit.fromMap(item!)).toList();
        return exhibits;
      } else {
        print('error status code ${response.statusCode}');
      }
    } catch (e) {
      print('error ${e.toString()}');
    }
    return null;
  }
}

List<dynamic> _cleanData(List<dynamic> responseBody) {
  //i will save the ids and the blobs to modify the data
  List<Map<String, dynamic>> idsAndBlobs = [];
  try {
    for (var item in responseBody) {
      item?.forEach((key, value) {
        // teh fields are pic1,pic2,pic3....
        int counter = 1;
        if (item[key].runtimeType.toString() == '_Map<String, dynamic>') {
          //assign the Uint8list
          // item['pic$counter'] = value['data'];
          // item.remove(key);
          idsAndBlobs.add({'id': item['id'], 'pic$counter': value['data']});
          counter++;
        }
      });
    }
  } catch (e) {
    print('Error cleaning data: ${e.toString()}');
  }
  return responseBody;
}
