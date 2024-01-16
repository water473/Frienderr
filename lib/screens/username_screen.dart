import 'package:flutter/material.dart';
import 'package:frienderr/screens/create_user.dart';
import 'package:frienderr/screens/main_page.dart';
import 'database_helper.dart';
import 'user.dart'; // Make sure to import your User model

class UsernameScreen extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const Text('Frienderr', style: TextStyle(fontSize: 50)),
              const SizedBox(height: 20),
              const Icon(Icons.people, size: 100),
              const SizedBox(height: 50),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Enter your username'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Enter your Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  // Verify user credentials
                  User? user =
                      await DatabaseHelper.instance.getUser(username, password);
                  if (user != null) {
                    // Navigate to MainPage on successful login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  } else {
                    // Show error on failed login
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid username or password')),
                    );
                  }
                },
                child: Text('Log In'),
              ),
              SizedBox(height: 20),
              const Text(
                'Don\'t have an account?',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateUser()),
                  );
                },
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
