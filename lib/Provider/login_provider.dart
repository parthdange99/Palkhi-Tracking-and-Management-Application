import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password, BuildContext context) async {
    _isLoading = true;

    notifyListeners();
    try {
      var response = await http.post(
        Uri.parse('http://192.168.1.43:3306/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({

          'email': email,

          'password': password,

        }),
      );
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        print("User Logged in successfully: ${data['token']}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login successful!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid credentials: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
        print("Invalid credentials: ${response.body}");
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
