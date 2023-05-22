import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sakyahe/screens/chat_screen.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../widgets/custom_icontext.dart';

class CarpoolScreen2 extends StatefulWidget {
  final String carpooldetailsID;

  const CarpoolScreen2({
    Key? key,
    required this.carpooldetailsID,
  }) : super(key: key);

  @override
  State<CarpoolScreen2> createState() => _CarpoolScreen2State();
}

class _CarpoolScreen2State extends State<CarpoolScreen2> {
  bool isJoined = false;
  bool hasArrived = false;
  DocumentSnapshot? carpoolDetailsSnapshot;
  DocumentSnapshot? driverDetailsSnapshot;
  String pickupLocation = '';
  String dropoffLocation = '';
  String carpoolName = '';
  String memberCount = '';
  String date = '';
  String time = '';
  String driverName = '';
  String carPlate = '';
  String carMake = '';
  String carColor = '';
  int carCapacity = 0;
  List<String> groupMembers = [];
  String driverUID = '';
  String _profilePictureUrl = '';

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
  void initState() {
    super.initState();
    fetchCarpoolDetails(widget.carpooldetailsID);
    _checkIfJoined();
  }

  void _checkIfJoined() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String userID = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> carpoolDetailsSnapshot =
          await FirebaseFirestore.instance
              .collection('carpool_details')
              .doc(widget.carpooldetailsID)
              .get();

      if (carpoolDetailsSnapshot.exists) {
        Map<String, dynamic>? carpoolData = carpoolDetailsSnapshot.data();
        if (carpoolData != null) {
          String groupID = carpoolData['groupID'];
          hasArrived = carpoolData['hasArrived'] ?? false;
          final DocumentSnapshot<Map<String, dynamic>> groupDetailsSnapshot =
              await FirebaseFirestore.instance
                  .collection('carpool_group')
                  .doc(groupID)
                  .get();

          if (groupDetailsSnapshot.exists) {
            Map<String, dynamic>? groupData = groupDetailsSnapshot.data();
            if (groupData != null) {
              List<dynamic>? studentUIDs = groupData['studentUIDs'];
              if (studentUIDs != null && studentUIDs.contains(userID)) {
                setState(() {
                  isJoined = true;
                });
              }
            }
          }
        }
      }
    }
  }

  void fetchCarpoolDetails(String carpooldetailsID) async {
    try {
      // Fetch carpool details
      DocumentSnapshot carpoolDetailsSnapshot = await FirebaseFirestore.instance
          .collection('carpool_details')
          .doc(carpooldetailsID)
          .get();

      if (carpoolDetailsSnapshot.exists) {
        Map<String, dynamic>? carpoolData =
            carpoolDetailsSnapshot.data() as Map<String, dynamic>?;

        if (carpoolData != null) {
          pickupLocation = carpoolData['pickupLocation'];
          dropoffLocation = carpoolData['dropoffLocation'];
          carpoolName = carpoolData['name'];
          date = DateFormat('MMM d, yyyy')
              .format((carpoolData['date'] as Timestamp).toDate());
          time = carpoolData['time'].toString().split('(')[1].split(')')[0];
          // Fetch group details
          String groupID = carpoolData['groupID'];
          DocumentSnapshot groupSnapshot = await FirebaseFirestore.instance
              .collection('carpool_group')
              .doc(groupID)
              .get();

          if (groupSnapshot.exists) {
            Map<String, dynamic>? groupData =
                groupSnapshot.data() as Map<String, dynamic>?;

            if (groupData != null) {
              List<dynamic> studentUIDs = groupData['studentUIDs'];
              driverUID = groupData['driverUID'];

              // Fetch driver details

              QuerySnapshot driverdetailsSnapshot = await FirebaseFirestore
                  .instance
                  .collection('driver_details')
                  .where('userID', isEqualTo: driverUID)
                  .get();

              if (driverdetailsSnapshot.size > 0) {
                DocumentSnapshot driverDoc = driverdetailsSnapshot.docs[0];
                Map<String, dynamic>? driverData =
                    driverDoc.data() as Map<String, dynamic>?;

                if (driverData != null) {
                  carPlate = driverData['carPlate'];
                  carMake = driverData['carMake'];
                  carColor = driverData['carColor'];
                  carCapacity = driverData['carCapacity'];
                }
              }

              DocumentSnapshot driverSnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(driverUID)
                  .get();

              if (driverSnapshot.exists) {
                Map<String, dynamic>? driverData =
                    driverSnapshot.data() as Map<String, dynamic>?;

                if (driverData != null) {
                  driverName = driverData['name'];

                  // Fetch students' names
                  List<String> studentNames = [];
                  studentNames.add(driverName);
                  for (String studentUID in studentUIDs) {
                    DocumentSnapshot studentSnapshot = await FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(studentUID)
                        .get();

                    if (studentSnapshot.exists) {
                      Map<String, dynamic>? studentData =
                          studentSnapshot.data() as Map<String, dynamic>?;

                      if (studentData != null) {
                        String studentName = studentData['name'];
                        studentNames.add(studentName);
                      }
                    }
                  }

                  setState(() {
                    memberCount = '${studentNames.length - 1}/${carCapacity}';
                    driverName = driverName;
                    groupMembers = studentNames;
                  });
                }
              }
            }
          }
        }
      }
    } catch (error) {
      print('Error fetching carpool details: $error');
    }
  }

  void _toggleJoinGroup() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String userID = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> carpoolDetailsSnapshot =
          await FirebaseFirestore.instance
              .collection('carpool_details')
              .doc(widget.carpooldetailsID)
              .get();

      if (carpoolDetailsSnapshot.exists) {
        Map<String, dynamic>? carpoolData =
            carpoolDetailsSnapshot.data() as Map<String, dynamic>?;

        if (carpoolData != null) {
          String groupID = carpoolData['groupID'];
          final DocumentReference<Map<String, dynamic>> groupDetailsRef =
              FirebaseFirestore.instance
                  .collection('carpool_group')
                  .doc(groupID);

          if (isJoined) {
            groupDetailsRef.update({
              'studentUIDs': FieldValue.arrayRemove([userID]),
            });
          } else {
            groupDetailsRef.update({
              'studentUIDs': FieldValue.arrayUnion([userID]),
            });
          }

          fetchCarpoolDetails(widget.carpooldetailsID);
        }

        setState(() {
          isJoined = !isJoined;
        });
      }
    }
  }

  Widget _buildChatButton() {
    if (isJoined) {
      return CustomButton(
        text: 'Chat',
        bgColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(),
            ),
          );
        },
        textColor: Colors.white,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_profilePictureUrl.isEmpty) {
      _fetchProfilePictureUrl(driverUID);
    }
    Widget PinLocation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
                hintText: pickupLocation, // pickupLocation
                isDense: true,
                filled: true,
                enabled: false,
                fillColor: Colors.black12,
                suffixIcon: Icon(Icons.push_pin),
                border: OutlineInputBorder()),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              isDense: true,
              hintText: dropoffLocation, //destinationLocation
              filled: true,
              enabled: false,
              fillColor: Colors.black12,
              suffixIcon: Icon(Icons.location_pin),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 20),
        Divider(
          color: Colors.black,
          // height: 30,
          thickness: 1,
          indent: 15,
          endIndent: 15,
        ),
      ],
    );

    Widget MapImageAndGroupName = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/map.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20)),
        ),
        const SizedBox(height: 5),
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.grey,
          backgroundImage: _profilePictureUrl.isNotEmpty
              ? NetworkImage(_profilePictureUrl)
              : null,
          child: _profilePictureUrl.isEmpty
              ? const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                )
              : null,
        ),
        const SizedBox(height: 5),
        Text(
          driverName, // driverName
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );

    Widget groupDetails = Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                carpoolName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildChatButton(),
            ]),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconText(
                  icon: Icons.person,
                  text: memberCount,
                  color: isJoined ? Colors.green : Colors.black,
                ),
                CustomIconText(
                  icon: Icons.calendar_today,
                  text: date, // date
                ),
                CustomIconText(
                  icon: Icons.access_time,
                  text: time, // time
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconText(icon: Icons.money, text: carPlate),
                CustomIconText(
                    icon: Icons.format_paint_outlined, text: carColor),
                CustomIconText(icon: Icons.drive_eta, text: carMake),
              ],
            ),
            const SizedBox(height: 10),
            const Text('₱50/person')
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carpool Details'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          PinLocation,
          MapImageAndGroupName,
          groupDetails,
        ],
      ),
      floatingActionButton: !hasArrived
          ? FloatingActionButton(
              // Check hasArrived before showing the button
              onPressed: _toggleJoinGroup,
              backgroundColor: isJoined ? Colors.red : Colors.green,
              child: isJoined ? const Text('Leave') : const Text('Join'),
            )
          : null,
    );
  }
}
