import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'nav.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({Key? key}) : super(key: key);

  @override
  _VerifyAccountScreenState createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  late File _studyLoadImage;
  bool _isImageUploaded = false;

  Future<void> _selectImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _studyLoadImage = File(pickedImage.path);
        _isImageUploaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isImageUploaded)
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(_studyLoadImage),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const Icon(
                Icons.image,
                size: 100,
              ),
            const SizedBox(height: 16),
            Text(
              _isImageUploaded ? 'Image Uploaded' : 'Upload Study Load Image',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isImageUploaded ? _verifyAccount : null,
              child: const Text('Verify Account'),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyAccount() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    userDoc.update({'isVerified': true}).then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Account Verified'),
            content: const Text('Congratulations! Your account has been verified.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => NavScreen()),
                    (route) => false,
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Verification Error'),
            content: const Text('An error occurred while verifying your account.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
