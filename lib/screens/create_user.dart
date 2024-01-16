import 'package:flutter/material.dart';
import 'interests_screen.dart';
import 'database_helper.dart';
import 'user.dart';

class CreateUser extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Making the form scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Text('Frienderr', style: TextStyle(fontSize: 50)),
              const SizedBox(height: 20),
              const Icon(Icons.people, size: 100),
              const SizedBox(height: 50),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Enter new username'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Enter new password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Enter your name, (First, Last)'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Enter your age'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _schoolController,
                decoration: InputDecoration(labelText: 'Enter your school'),
              ),
              SizedBox(height: 20),
              // Add a button to submit the form
              ElevatedButton(
                onPressed: () async {
                  // Save the username in a local variable
                  String username = _usernameController.text;

                  User newUser = User(
                    name: _nameController.text,
                    username: username,
                    password: _passwordController.text,
                    age: _ageController.text,
                    school: _schoolController.text,
                    interests: '', // Initially empty
                    image:
                        ' ', // Update this as per your image handling (path to image) blank for now
                  );

                  await DatabaseHelper.instance.insertUser(newUser);

                  // Check if the context is still valid
                  //if (!mounted) return; only works on a statefull widget

                  // Navigate to InterestsScreen with the username
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InterestsScreen(username: username),
                    ),
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
