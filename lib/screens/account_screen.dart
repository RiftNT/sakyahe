import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sakyahe/screens/profile_screen.dart';
import 'package:sakyahe/screens/welcome_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    Widget profileSection = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: ProfileScreen(),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Icon(
                        Icons.circle,
                        size: 100,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: userDoc.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Placeholder();
                        }
                        final data = snapshot.data!.data();
                        final name =
                            (data as Map<String, dynamic>)['name'] as String? ??
                                'User';
                        final phoneNumber = data.containsKey('phoneNumber')
                            ? data['phoneNumber'] as String
                            : 'Phone';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                name,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Text(
                              phoneNumber,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 50,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 16,
            thickness: 1,
            indent: 12,
            endIndent: 12,
          ),
        ],
      ),
    );

    Widget pagesSection = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              InkWell(
                onTap: () {
                  // Navigate to settings page
                },
                child: const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigate to support page
                },
                child: const ListTile(
                  leading: Icon(Icons.support),
                  title: Text('Support'),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                    (route) => false,
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
              const SizedBox(height: 40),
              const Divider(
                color: Colors.grey,
                height: 16,
                thickness: 1,
                indent: 12,
                endIndent: 12,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
        title: const Text('Account'),
      ),
        body: ListView(
          children: [
            profileSection,
            pagesSection,
          ],
        ),
      );
  }
}
