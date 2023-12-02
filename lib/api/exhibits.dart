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
        var items = jsonDecode(response.body)['exhibits'];

        // List<Exhibit> exhibits =
        //     items.map((item) => Exhibit.fromMap(item!)).toList();

        List<Exhibit> exhibits = [];

        for (var item in items) {
          var exhibit = Exhibit.fromMap(item);
          exhibits.add(exhibit);
        }

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
