import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:sakyahe/screens/chat_screen.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import '../widgets/custom_icontext.dart';

class DriverCarpoolScreen2 extends StatefulWidget {
  final String carpooldetailsID;

  const DriverCarpoolScreen2({
    Key? key,
    required this.carpooldetailsID,
  }) : super(key: key);

  @override
  State<DriverCarpoolScreen2> createState() => _DriverCarpoolScreen2State();
}

class _DriverCarpoolScreen2State extends State<DriverCarpoolScreen2> {
  String buttonText = 'Begin Carpool';
  bool isJoined = false;
  bool isArrived = false;
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

  @override
  void initState() {
    super.initState();
    fetchCarpoolDetails(widget.carpooldetailsID);
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
          isArrived = carpoolData['hasArrived'];
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
              String driverUID = groupData['driverUID'];

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
                    memberCount = '${studentNames.length}/${carCapacity}';
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

  Future<void> _toggleJoinGroup() async {
    setState(() {
      if (!isJoined && !isArrived) {
        isJoined = true;
        buttonText = 'Picking-up Passengers';
      } else if (buttonText == 'Picking-up Passengers') {
        buttonText = 'En route to Destination';
      } else if (buttonText == 'En route to Destination') {
        buttonText = 'Arrived';
        isArrived = true;
      }
    });

    if (isArrived) {
      try {
        await FirebaseFirestore.instance
            .collection('carpool_details')
            .doc(widget.carpooldetailsID)
            .update({'hasArrived': true});
      } catch (error) {
        print('Error updating hasArrived field: $error');
      }
    }
  }

  void _deleteCarpoolGroup() async {
    try {
      // Fetch carpool details
      DocumentSnapshot carpoolDetailsSnapshot = await FirebaseFirestore.instance
          .collection('carpool_details')
          .doc(widget.carpooldetailsID)
          .get();

      if (carpoolDetailsSnapshot.exists) {
        Map<String, dynamic>? carpoolData =
            carpoolDetailsSnapshot.data() as Map<String, dynamic>?;

        if (carpoolData != null) {
          String groupID = carpoolData['groupID'];

          await FirebaseFirestore.instance
              .collection('carpool_details')
              .doc(widget.carpooldetailsID)
              .update({'isDeleted': true});

          Navigator.pop(context);
        }
      }
    } catch (error) {
      print('Error deleting carpool group: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget PinLocation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            style: TextStyle(fontSize: 15),
            enabled: false,
            decoration: InputDecoration(
              hintText: pickupLocation,
              isDense: true,
              filled: true,
              fillColor: Colors.black12,
              suffixIcon: Icon(Icons.push_pin),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              isDense: true,
              hintText: dropoffLocation,
              enabled: false,
              filled: true,
              fillColor: Colors.black12,
              suffixIcon: Icon(Icons.location_pin),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 20),
        Divider(
          color: Colors.black,
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
            borderRadius: BorderRadius.circular(20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  carpoolName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconText(
                  icon: Icons.person,
                  text: memberCount,
                ),
                CustomIconText(
                  icon: Icons.calendar_today,
                  text: date,
                ),
                CustomIconText(
                  icon: Icons.access_time,
                  text: time,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconText(icon: Icons.money, text: carPlate),
                CustomIconText(
                  icon: Icons.format_paint_outlined,
                  text: carColor,
                ),
                CustomIconText(icon: Icons.drive_eta, text: carMake),
              ],
            ),
            ExpansionTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Members:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              leading: Icon(Icons.group),
              children: [
                for (var member in groupMembers)
                  CustomIconText(
                    icon: Icons.person,
                    text: member,
                  ),
              ],
            ),
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
          const SizedBox(height: 20),
          if (!isArrived)
            CustomButton(
              bgColor: isArrived
                  ? Colors.red
                  : buttonText == 'Picking-up Passengers'
                      ? Colors.yellow.shade800
                      : buttonText == 'En route to Destination'
                          ? Colors.green.shade700
                          : Colors.grey.shade700,
              onPressed: isArrived ? () {} : () => _toggleJoinGroup(),
              text: buttonText,
              textColor: Colors.white,
            ),
          const SizedBox(height: 10),
          if (isArrived)
            const Text(
              'Has Arrived',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (!isArrived)
            TextButton(
              onPressed: _deleteCarpoolGroup,
              child: const Text(
                'Delete Carpool',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
