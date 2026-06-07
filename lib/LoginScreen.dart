import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/login_provider.dart';
import 'Signup.dart';
import 'ForgetPassword.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Text(
                  'विठोबा!!',
                  style: TextStyle(fontSize: 30, color: Colors.orangeAccent),
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.email, size: 20, color: Colors.black),
                  hintText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.lock, size: 20, color: Colors.black),
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  print("Hiii");
                  loginProvider.login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    context,
                  );
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Center(

                    child: loginProvider.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()),
                  );
                },
                child: Center(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Center(
                  child: Text(
                    'New User? Create Account',
                    style: TextStyle(color: Colors.orangeAccent),
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

