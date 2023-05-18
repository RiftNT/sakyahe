import 'package:flutter/material.dart';
import 'package:sakyahe/screens/chat_screen.dart';
import 'package:sakyahe/widgets/custom_button.dart';

import '../widgets/custom_icontext.dart';

class DriverCarpoolScreen2 extends StatefulWidget {
  const DriverCarpoolScreen2({Key? key}) : super(key: key);

  @override
  State<DriverCarpoolScreen2> createState() => _DriverCarpoolScreen2State();
}

class _DriverCarpoolScreen2State extends State<DriverCarpoolScreen2> {
  String buttonText = 'Begin Carpool';
  bool isJoined = false;
  bool isArrived = false;

  void _toggleJoinGroup() {
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
  }

  @override
  Widget build(BuildContext context) {
    Widget PinLocation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            style: TextStyle(fontSize: 15),
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Cordova',
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
              hintText: 'USC-TC',
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
              children: const [
                Text(
                  'CARPOOL GROUP 1',
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
                  text: '3/4',
                ),
                CustomIconText(
                  icon: Icons.calendar_today,
                  text: 'June 15, 2023',
                ),
                CustomIconText(
                  icon: Icons.access_time,
                  text: '8:00 AM',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconText(icon: Icons.money, text: 'GAH 1234'),
                CustomIconText(
                  icon: Icons.format_paint_outlined,
                  text: 'White',
                ),
                CustomIconText(icon: Icons.drive_eta, text: 'Toyota'),
              ],
            ),
            const SizedBox(height: 10),
            const Text('₱50/person'),
            ExpansionTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Group members:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              leading: Icon(Icons.group),
              children: [
                CustomIconText(
                  icon: Icons.person,
                  text: 'Juan Dela Cruz',
                ),
                CustomIconText(
                  icon: Icons.person,
                  text: 'Maria Clara',
                ),
                CustomIconText(
                  icon: Icons.person,
                  text: 'Pedro Parker',
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
          CustomButton(
            bgColor: Colors.red,
            onPressed: () {},
            text: 'Delete Carpool Group',
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
