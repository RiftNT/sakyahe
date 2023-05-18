import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sakyahe/screens/nav.dart';
import 'package:sakyahe/screens/register_screen.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/home_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 120),
                const Text(
                  "What should people call you?",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Enter your name",
                      hintText: "e.g. Juan Dela Cruz",
                    ),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    text: "Submit",
                    bgColor: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final user = _auth.currentUser;
                        if (user != null) {
                          final name = _nameController.text;
                          final phoneNumber = RegisterScreen.phoneNumber;
                          final uid = user.uid;
                          await _firestore
                              .collection('users')
                              .doc(uid)
                              .set({
                                'uid': uid.toString(),
                                'name': name,
                                'phoneNumber': phoneNumber,
                                'type': 'student'
                              });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavScreen(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
