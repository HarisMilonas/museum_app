import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NewsLetterApi {
  var baseUrl = '10.0.2.2:80';

  Future<String> sendEmail(
      String userSubject, String message, String emailTo) async {
    try {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      const serviceId = 'service_q7n2vzr';
      const tempalteId = 'template_03ukgom';
      const userId = 'kMHxoHPT2K2vPZhHY';

      final response = await http.post(url,
          headers: {'origin': baseUrl, 'Content-Type': 'application/json'},
          body: jsonEncode({
            'service_id': serviceId,
            'template_id': tempalteId,
            'user_id': userId,
            'template_params': {
              'user_subject': userSubject,
              'message': message,
              'to_email': emailTo
            }
          }));

      if (response.statusCode == 200) {
        return "Email Send Sucessfully!";
      } else {
        return "Error: ${response.statusCode} ${response.body.toString()}";
      }
    } catch (error) {
      return "Error: ${error.toString()}";
    }
  }

  Future<List<String>?> getNewsLetterEmails() async {
    try {
      var url = Uri.http(baseUrl, "newsletter");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);

        var emailsMap = body['emails'];

        List<String> emails = [];

        emailsMap?.forEach((emailMap) {
          emails.add(emailMap['email']);
        });
        return emails;
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
