import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:museum_app/models/exhibit.dart';

class ExhibitApi {
  var baseUrl = '10.0.2.2:80';

  Future<List<Exhibit>?> getExhibits(String urlPath) async {
    try {
      var url = Uri.http(baseUrl, urlPath);
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
        if (kDebugMode) {
          print('error status code ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }

  Future<List<Exhibit>?> getExhibitsCategory(String category) async {
    if (kDebugMode) {
      print(category);
    }
    try {
      var url = Uri.http(baseUrl, 'exhibits-category');

      var response = await http.post(url, body: {"category": category});
      if (response.statusCode == 200) {
        var items = jsonDecode(response.body)['exhibits'];

        List<Exhibit> exhibits = [];

        for (var item in items) {
          var exhibit = Exhibit.fromMap(item);
          exhibits.add(exhibit);
        }

        return exhibits;
      } else {
        if (kDebugMode) {
          print('error status code ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error ${e.toString()}');
      }
    }
    return null;
  }
}
