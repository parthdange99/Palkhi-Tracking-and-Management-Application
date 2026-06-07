import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VolunteeringProvider with ChangeNotifier {
  Future<void> registerVolunteer({
    required String name,
    required String email,
    required String mobile,
    required String address,
    required String city,
    required String state,
    required List<String> skills,
    required String availability,
    required String additionalInfo,
    required BuildContext context,
  }) async {
    try {
      // Convert skills list to a comma-separated string
      final skillsString = skills.join(',');

      final response = await http.post(
        Uri.parse('http://192.168.1.60:3307/registerVolunteer'), // Adjust the URL as per backend
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'mobile': mobile,
          'address': address,
          'city': city,
          'state': state,
          'skills': skillsString,
          'availability': availability,
          'additional_info': additionalInfo,
        }),
      );
      print(response.statusCode);

      print('Response code: ${response.statusCode}');

      print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Volunteer registered successfully: ${data['message']}"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        var errorMessage = 'Registration failed';
        try {
          var errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (_) {
          // Ignore parsing errors
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error occurred: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
