import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'carpool_screen.dart';
import 'messages_screen.dart';
import 'account_screen.dart';

class NonVerNavScreen extends StatefulWidget {
  const NonVerNavScreen({Key? key}) : super(key: key);

  @override
  State<NonVerNavScreen> createState() => _NonVerNavScreenState();
}

class _NonVerNavScreenState extends State<NonVerNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const AccountScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
