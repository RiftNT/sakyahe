import 'package:flutter/material.dart';
import 'package:sakyahe/widgets/custom_button.dart';

class CarpoolScreen2 extends StatefulWidget {
  const CarpoolScreen2({super.key});

  @override
  State<CarpoolScreen2> createState() => _CarpoolScreen2State();
}

class _CarpoolScreen2State extends State<CarpoolScreen2> {
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
        Text(
          'CARPOOL GROUP 1',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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

    Widget GroupDetails = Column(
      //kani idk na 
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '');
                    },
                    text: "₱ 50      |     Join Group ",
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: const [
                    Text(
                      'Juan Dela Cruz3',
                      style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Juan Dela Cruz4',
                      style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carpool Page 2'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PinLocation,
            MapImageAndGroupName,
            GroupDetails,
          ],
        ),
      ),
    );
  }
}
