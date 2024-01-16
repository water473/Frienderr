import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'database_helper.dart';
import 'user.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<SwipeItem> _swipeItems = [];
  List<User> defaultUsers = [];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fetchDefaultUsers();
  }

  void _fetchDefaultUsers() async {
    defaultUsers = await DatabaseHelper.instance.users();
    for (var user in defaultUsers) {
      _swipeItems.add(SwipeItem(
        content: user,
        likeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Liked ${user.name}"),
            duration: Duration(milliseconds: 500),
          ));
        },
        nopeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Nope ${user.name}"),
            duration: Duration(milliseconds: 500),
          ));
        },
        superlikeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Superliked ${user.name}"),
            duration: Duration(milliseconds: 500),
          ));
        },
      ));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    setState(() {}); // Rebuild the widget with the fetched users
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: SwipeCards(
                  matchEngine: _matchEngine,
                  itemBuilder: (BuildContext context, int index) {
                    return buildUserCard(defaultUsers[index]);
                  },
                  onStackFinished: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Stack Finished"),
                      duration: Duration(milliseconds: 500),
                    ));
                  },
                  itemChanged: (SwipeItem item, int index) {
                    print("item: ${item.content.name}, index: $index");
                  },
                  upSwipeAllowed: true,
                  fillSpace: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.nope();
                      },
                      child: Text("Nope")),
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.superLike();
                      },
                      child: Text("Superlike")),
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.like();
                      },
                      child: Text("Like")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserCard(User user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
// If you are using local assets for default images, make sure they are listed in your pubspec.yaml
            Image.asset(user.imagePath,
                width: 200, height: 200, fit: BoxFit.cover),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.username,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(user.name, style: TextStyle(fontSize: 20)),
                  Text('Age: ${user.age}', style: TextStyle(fontSize: 16)),
                  Text('School: ${user.school}',
                      style: TextStyle(fontSize: 16)),
                  Text('Interests: ${user.interests}',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
      elevation: 4.0, // Optional: Add shadow effect
    );
  }
}
