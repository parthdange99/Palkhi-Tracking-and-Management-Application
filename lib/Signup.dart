import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/signup_provider.dart'; // Import your provider

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New User Registration'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(

          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Full Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(hintText: 'Mobile Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile number is required';
                  } else if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                    return 'Enter a valid mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
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
              DropdownButtonFormField<String>(
                value: gender,
                decoration: InputDecoration(hintText: 'Gender'),
                items: ['Male', 'Female', 'Other'].map((String category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    gender = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Gender is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(hintText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: pincodeController,
                decoration: InputDecoration(hintText: 'Pincode'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pincode is required';
                  } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                    return 'Enter a valid 6-digit pincode';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 8 ||
                      !RegExp(r'^(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
                    return 'Password must be at least 8 characters long, contain an uppercase letter and a number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              //Register User button
              GestureDetector(
                onTap: () {
                  print("Register User button Tapped");
                  if (_formKey.currentState!.validate()) {
                    Provider.of<SignupProvider>(context, listen: false).registerUser(
                      name: nameController.text,
                      mobile: mobileController.text,
                      email: emailController.text,
                      gender: gender!,
                      address: addressController.text,
                      pincode: pincodeController.text,
                      password: passwordController.text,
                      context: context,
                    );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(

                    color: Colors.orangeAccent,

                    borderRadius: BorderRadius.circular(10),

                  ),

                  child: Center(
                    child: Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
