import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void resetPassword(String email) async {
    try {
      
      var response = await http.post(
        Uri.parse('http://192.168.1.37:8000/auth/forgot-password'), // Replace with your backend URL
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Password reset email sent: ${data['message']}");
        // Show success message to the user
      } else {
        print("Error: ${response.body}");
        // Show error message to the user
      }
    } catch (e) {
      print(e.toString());
      // Handle network or other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Enter your email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    resetPassword(emailController.text);
                  }
                },
                child: Text('Send Reset Link', style: TextStyle(color: Colors.orangeAccent ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
