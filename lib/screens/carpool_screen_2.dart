import 'package:flutter/material.dart';
import 'package:sakyahe/widgets/custom_button.dart';

import '../widgets/custom_icontext.dart';

class CarpoolScreen2 extends StatefulWidget {
  const CarpoolScreen2({super.key});

  @override
  State<CarpoolScreen2> createState() => _CarpoolScreen2State();
}

class _CarpoolScreen2State extends State<CarpoolScreen2> {
  bool isJoined = false;

  void _toggleJoinGroup() {
    setState(() {
      isJoined = !isJoined;
    });
  }

  Widget _buildChatButton() {
    if (isJoined) {
      return CustomButton(
        text: 'Chat',
        bgColor: Colors.blue,
        onPressed: () {
          // chat page
        },
        textColor: Colors.white,
      );
    } else {
      return Container();
    }
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
            decoration: InputDecoration(
                hintText: 'Pick-up',
                isDense: true,
                filled: true,
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
              hintText: 'Destination',
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
          // height: 30,
          thickness: 1,
          indent: 15,
          endIndent: 15,
        ),
      ],
    );

    Widget MapImageAndGroupName = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          //dako mukuha ug spacing, di mapadako ang width
          Icons.rectangle_rounded,
          size: 150,
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        Icon(
          //dako mukuha ug spacing, di mapadako ang width
          Icons.circle,
          size: 80,
          color: Colors.black12,
        ),
        SizedBox(height: 5),
        Text(
          'Juan Dela Cruz',
          style: TextStyle(
            fontSize: 17,
            // fontWeight: FontWeight.bold,
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
                const Text(
                  'CARPOOL GROUP 1',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ), 
                _buildChatButton(),
              ]
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
                CustomIconText(
                  icon: Icons.money, 
                  text: 'GAH 1234'
                ),
                CustomIconText(icon: Icons.format_paint_outlined, text: 'White'),
                CustomIconText(icon: Icons.drive_eta, text: 'Toyota'),
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          PinLocation,
          MapImageAndGroupName,
          groupDetails,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleJoinGroup,
        backgroundColor: isJoined ? Colors.red : Colors.green,
        child: isJoined ? const Text('Leave') : const Text('Join'),
      ),
    );
  }
}
