import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sakyahe/screens/nav.dart';
import 'package:sakyahe/screens/welcome_screen.dart';

import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    final List _RideList = [
      'RIDE 1',
      'RIDE 2',
      'RIDE 3',
      'RIDE 4',
    ];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("SAKYAHE"),
        elevation: 0,
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: size.height * 0.2 - 25,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 41, 98, 255),
                    ),
                  ),
                  Positioned(
                      child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 54,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.blue.shade900.withOpacity(0.23))
                        ]),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                        color: Colors.blue.shade300
                                            .withOpacity(0.5)),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    suffixIcon: Icon(Icons.search))))
                      ],
                    ),
                  )),
                  //map
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 100.0,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20)),
                      )),
                ],
              ),
            ),
            //for Upcomming
            Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                // padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Upcoming Rides",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "See All",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const ChatScreen(),
                        //   ),
                        // );
                      },
                      child: Material(
                        child: ListTile(
                          subtitle: Column(
                            children: [
                              Text("Monday , April 24 , 2023 - 8:00am"),
                              Row(
                                children: [
                                  Text("Gaisano Mactan Island Mall"),
                                  Text("-"),
                                  Text("USC Talamban Campus")
                                ],
                              )
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Soqueno Carpool"),
                              Text(" | "),
                              Text("Dominic Soqueno"),
                            ],
                          ),
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const ChatScreen(),
                      //   ),
                      // );
                    },
                    child: ListTile(
                      subtitle: Column(
                        children: [
                          Text("Monday , April 24 , 2023 - 8:00am"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Gaisano Mactan Island Mall"),
                              Text("-"),
                              Text("USC Talamban Campus")
                            ],
                          )
                        ],
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LO  Carpool",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(" | "),
                          Text("Dominic Soqueno"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

/*Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(height: 120),
                FutureBuilder<DocumentSnapshot>(
                  future: userDoc.get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    // final data = snapshot.data?.data() ?? {};
                    // final name =
                    //     (data as Map<String, dynamic>)['name'] as String? ??
                    //         'User';

                    return Text(
                      'Homepage: Hello',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    text: "Logout",
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ), */
