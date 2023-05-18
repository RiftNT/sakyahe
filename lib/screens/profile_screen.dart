import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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
                      child: isEditing
                          ? TextFormField(
                              controller: _nameController,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            )
                          : StreamBuilder<DocumentSnapshot>(
                              stream: userDoc.snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('Loading...');
                                }
                                final data = snapshot.data!.data();
                                final name = (data as Map<String, dynamic>)['name']
                                        as String? ??
                                    'User';
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditing = true;
                                      _nameController.text = name;
                                    });
                                  },
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    if (isEditing)
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          setState(() {
                            isEditing = false;
                            _updateUserName(_nameController.text);
                          });
                        },
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
                            return const Text('Loading...');
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

  Future<void> _updateUserName(String name) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
    await userDoc.update({'name': name});
  }
}
