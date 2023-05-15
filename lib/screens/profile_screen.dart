import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Profile picture section
            Container(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          Icon(
                            Icons.circle,
                            size: 150,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // User name section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              child: Container(
                height: 60,
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 16),
                    Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: userDoc.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text('Loading...');
                          }
                          final data = snapshot.data!.data();
                          final name =
                              (data as Map<String, dynamic>)['name'] as String? ??
                                  'User';
                          return Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Phone number section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              child: Container(
                height: 30,
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 16),
                    Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: userDoc.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text('Loading...');
                          }
                          final data = snapshot.data!.data();
                          final phoneNumber =
                              (data as Map<String, dynamic>)['phoneNumber']
                                      as String? ??
                                  'User';
                          return Text(
                            phoneNumber,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Spacer to push everything to the top
            Spacer(),
          ],
        ),
      ),
    );
  }
}
