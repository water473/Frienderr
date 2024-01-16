import 'package:flutter/material.dart';
import 'username_screen.dart';
import 'chat_screen.dart';
import 'global.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentUser == null
          ? Center(child: Text('No user logged in'))
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${currentUser!.username}',
                      style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text('Name: ${currentUser!.name}',
                      style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text('Age: ${currentUser!.age}',
                      style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text('School: ${currentUser!.school}',
                      style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Text('Interests: ${currentUser!.interests}',
                      style: TextStyle(fontSize: 24)),
                  ElevatedButton(
                    onPressed: () {
                      // Set currentUser to null for logout
                      currentUser = null;

                      // Navigate back to the login screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UsernameScreen()),
                      );
                    },
                    child: Text('Log Out'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .pink, // Optional: style the logout button differently
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
