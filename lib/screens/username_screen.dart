import 'package:flutter/material.dart';
import 'package:frienderr/screens/create_user.dart';
import 'package:frienderr/screens/main_page.dart';

class UsernameScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Text(
              'Frienderr',
              style: TextStyle(fontSize: 50)
            ),

            const SizedBox(height: 20),

            const Icon(
              Icons.people,
              size: 100,
            ),

            const SizedBox(height: 50),

            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Enter your username'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Enter your Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
              },
              child: Text('Log In'),
            ),
            SizedBox(height: 20),
             const Text(
              'Don\'t have an account?',
              style: TextStyle(fontSize: 20)
            ),
            SizedBox(height: 10),
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateUser(),
                  ),
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
