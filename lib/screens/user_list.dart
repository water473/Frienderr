import 'package:flutter/material.dart';
import 'user_profile.dart';

class UserList extends StatelessWidget {
  final List<User> exampleUsers = [
    User(username: 'User1', interests: ['Reading', 'Sports']),
    User(username: 'User2', interests: ['Traveling', 'Cooking']),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exampleUsers.length,
      itemBuilder: (context, index) {
        return buildUserTile(exampleUsers[index], context);
      },
    );
  }

  Widget buildUserTile(User user, BuildContext context) {
    return ListTile(
      title: Text(user.username),
      onTap: () {
        showUserInterestsAndChat(user, context);
      },
    );
  }

  void showUserInterestsAndChat(User user, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: [
              // User's interests
              Text('Interests: ${user.interests.join(', ')}'),
              ElevatedButton(
                onPressed: () {
                  startChatWithUser(user, context);
                  Navigator.pop(context);
                },
                child: Text('Start Chat'),
              ),
            ],
          ),
        );
      },
    );
  }

  void startChatWithUser(User user, BuildContext context) {
    // Implement chat initiation logic here
    // You can open a new chat window or add it to the chats tab
    // For simplicity, let's print a message for now
    print('Chat started with ${user.username}');
  }
}

class User {
  final String username;
  final List<String> interests;

  User({required this.username, required this.interests});
}
