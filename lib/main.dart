import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frienderr',
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        body: const [
          Center(
            child: Text(
              'Finder',
            ),
          ),
          Center(
            child: Text(
              'Organizations',
            ),
          ),
          Center(
            child: Text(
              'Chats',
            ),
          ),
          Center(
            child: Text(
              'Profile'
            )
          )
        ][pageIndex],
        bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              pageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.search),
              icon: Icon(Icons.search),
              label: 'Finder',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.people),
              icon: Icon(Icons.people_outline),
              label: 'Organizations',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.chat_bubble),
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}