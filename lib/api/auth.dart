import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  var baseUrl = '10.0.2.2:80';

  Future<Map<String, dynamic>> getAuthenticatedUser(
      String username, String password, BuildContext context) async {
    try {
      var url = Uri.http(baseUrl, 'request-token');

      var response = await http
          .post(url, body: {"username": username, "password": password});
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var user = User.fromMap(body['credentials']);
        return {"user": user, "message": "Welcome back ${user.name}!"};
      } else {
        return {"message": body["message"]};
      }
    } catch (error) {
      return {"message": error.toString()};
    }
  }
}
