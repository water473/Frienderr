import 'package:flutter/material.dart';
import 'interests_screen.dart';

class CreateUser extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
              decoration: InputDecoration(labelText: 'Enter new username'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Enter new Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterestsScreen(),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
