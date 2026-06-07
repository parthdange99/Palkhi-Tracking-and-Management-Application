import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  String email = "";
  String userId = "";
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? "";
      userId = prefs.getString('user_id') ?? "";
      _fetchUserDetails();
    });
  }

  Future<void> _fetchUserDetails() async {
    final response = await http.get(Uri.parse("https://your-ci4-api.com/api/getUser/$userId"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _nameController.text = data['name'];
      });
    } else {
      print("Failed to load user data");
    }
  }

  Future<void> _updateUserName() async {
    final response = await http.post(
      Uri.parse("https://your-ci4-api.com/api/updateUser"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId, "name": _nameController.text}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _isEditing = false;
      });
    } else {
      print("Failed to update username");
    }
  }

  Future<void> _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://api.dicebear.com/7.x/adventurer/png'), // Random avatar
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              enabled: _isEditing,
              decoration: InputDecoration(
                labelText: 'User Name',
                suffixIcon: IconButton(
                  icon: Icon(_isEditing ? Icons.check : Icons.edit),
                  onPressed: () {
                    if (_isEditing) {
                      _updateUserName();
                    } else {
                      setState(() {
                        _isEditing = true;
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: email,
              decoration: InputDecoration(labelText: 'Email'),
              enabled: false,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut,
              child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
