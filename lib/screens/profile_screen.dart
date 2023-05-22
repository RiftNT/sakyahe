import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  TextEditingController _nameController = TextEditingController();
  late File _profilePicture;
  String _profilePictureUrl = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfilePictureUrl(final uid) async {
    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profilePictures')
        .child('$uid.jpg');

    try {
      final downloadUrl = await storageRef.getDownloadURL();
      setState(() {
        _profilePictureUrl = downloadUrl;
      });
    } catch (error) {
      print('Failed to fetch profile picture URL: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    if (_profilePictureUrl.isEmpty) {
      _fetchProfilePictureUrl(uid);
    }

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey,
                    backgroundImage: _profilePictureUrl.isNotEmpty
                        ? NetworkImage(_profilePictureUrl)
                        : null,
                    child: _profilePictureUrl.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.blueAccent[700],
                      ),
                      onPressed: () {
                        _selectProfilePicture();
                      },
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
                                final name =
                                    (data as Map<String, dynamic>)['name']
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
            Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> _selectProfilePicture() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profilePicture = File(pickedImage.path);
      });
      _uploadProfilePicture();
    }
  }

  Future<void> _uploadProfilePicture() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profilePictures')
        .child('$uid.jpg');

    final uploadTask = storageRef.putFile(_profilePicture);
    final snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == firebase_storage.TaskState.success) {
      final downloadUrl = await storageRef.getDownloadURL();
      setState(() {
        _profilePictureUrl = downloadUrl;
      });
    }
  }

  Future<void> _updateUserName(String name) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
    await userDoc.update({'name': name});
  }
}
