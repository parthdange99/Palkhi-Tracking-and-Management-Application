import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupProvider with ChangeNotifier {

  Future<void> registerUser({
    required String name,
    required String mobile,
    required String email,
    required String gender,
    required String address,
    required String pincode,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.1.43:3306/auth/Signup'), // Replace with your backend URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'full_name': name,
          'mobile': mobile,
          'email': email,
          'gender': gender,
          'address': address,
          'pincode': pincode,
          'password': password,
        }),
      );
      print(response.statusCode);
      print('Response code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User Registered successfully: ${data['message']}"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration failed with code ${response.statusCode}: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
