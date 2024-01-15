import 'package:flutter/material.dart';
import 'main_page.dart';

class InterestsScreen extends StatefulWidget {
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
        onPressed: navigateToMainPage,
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
    return CheckboxListTile(
      title: Text(interest),
      value: selectedInterests.contains(interest),
      onChanged: (bool? value) {
        if (value != null) {
          setState(() {
            value
                ? selectedInterests.add(interest)
                : selectedInterests.remove(interest);
          });
        }
      },
    );
  }

  void navigateToMainPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
  }
}
