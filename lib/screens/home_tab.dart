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
    setState(() {});
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
                  onStackFinished:
                      _resetSwipeStack, // Reset the stack when finished
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

  void _resetSwipeStack() {
    List<SwipeItem> newSwipeItems = defaultUsers.map((user) {
      return SwipeItem(
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
      );
    }).toList();

    setState(() {
      _swipeItems = newSwipeItems;
      _matchEngine = MatchEngine(swipeItems: _swipeItems);
    });
  }

  Widget buildUserCard(User user) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
// Image at top center
          Image.asset(user.imagePath,
              width: MediaQuery.of(context).size.width,
              height: 250,
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
// Username in bold
                Text(user.username,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(user.name, style: TextStyle(fontSize: 20)),
                Text('Age: ${user.age}', style: TextStyle(fontSize: 16)),
                Text('School: ${user.school}', style: TextStyle(fontSize: 16)),
                Text('Interests: ${user.interests}',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
      elevation: 10.0,
    );
  }
}
