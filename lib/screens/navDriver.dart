import 'package:flutter/material.dart';
import 'package:sakyahe/screens/driver_carpool_screen.dart';

import 'home_screen.dart';
import 'carpool_screen.dart';
import 'messages_screen.dart';
import 'account_screen.dart';

class NavDriverScreen extends StatefulWidget {
  const NavDriverScreen({Key? key}) : super(key: key);

  @override
  State<NavDriverScreen> createState() => _NavDriverScreenState();
}

class _NavDriverScreenState extends State<NavDriverScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const DriverCarpoolScreen(),
    const MessagesScreen(),
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
            icon: Icon(Icons.drive_eta_outlined),
            label: 'Carpool',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
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
