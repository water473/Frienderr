import 'package:flutter/material.dart';
import 'package:frienderr/screens/username_screen.dart';
import 'main_page.dart';
import 'database_helper.dart';
import 'user.dart';

class InterestsScreen extends StatefulWidget {
  final String username;

  InterestsScreen({Key? key, required this.username}) : super(key: key);

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<String> interests = [
    'Reading',
    'Sports',
    'Traveling',
    'Cooking',
    'Movies',
    'Gaming',
    'Music',
    'Technology',
  ];
  List<String> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Interests'),
      ),
      body: buildInterestsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // comma-separated string
          String selectedInterestsString = selectedInterests.join(', ');

          User? user =
              await DatabaseHelper.instance.getUserByUsername(widget.username);
          if (user != null) {
            // Update the user's interests
            User updatedUser = User(
              id: user.id,
              name: user.name,
              username: user.username,
              password: user.password,
              age: user.age,
              school: user.school,
              interests: selectedInterestsString,
              imagePath: user.imagePath,
            );

            // Update the user in the database
            await DatabaseHelper.instance.updateUser(updatedUser);

            // Navigate to the next screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UsernameScreen()),
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }

  Widget buildInterestsList() {
    return ListView.builder(
      itemCount: interests.length,
      itemBuilder: (context, index) {
        return buildInterestTile(interests[index]);
      },
    );
  }

  Widget buildInterestTile(String interest) {
    return ListTile(
      title: Text(interest),
      trailing: Checkbox(
        value: selectedInterests.contains(interest),
        onChanged: (bool? value) {
          setState(() {
            if (value != null && value) {
              selectedInterests.add(interest);
            } else {
              selectedInterests.remove(interest);
            }
          });
        },
      ),
    );
  }
}
