import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pragatiproject/user.dart';

class UserdataProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;

  // Getter for a single user (assuming only one user is logged in)
  User? get user => _users.isNotEmpty ? _users.first : null;

  // Getter for all users (if needed)
  List<User> get users => _users;

  // Loading status
  bool get isLoading => _isLoading;

  // Clear user data on logout
  void logout() {
    _users.clear(); // Clear the user data list
    notifyListeners(); // Notify widgets that rely on this provider
    print('User logged out successfully');
  }
  // Fetch users from the database
  Future<void> fetchUsers() async {
    const url = 'http://192.168.1.48:3306/auth/Signup'; // Ensure the backend API endpoint is correct
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> data = jsonDecode(response.body);

        // Map each JSON object to a `User` object
        _users = data.map((json) => User.fromJson(json)).toList();
        print('Users fetched successfully: ${_users.length}');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
