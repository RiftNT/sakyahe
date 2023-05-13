import 'package:flutter/material.dart';
import 'package:sakyahe/screens/carpool_screen_2.dart';

class CarpoolScreen extends StatefulWidget {
  const CarpoolScreen({super.key});

  @override
  State<CarpoolScreen> createState() => _CarpoolScreenState();
}

class _CarpoolScreenState extends State<CarpoolScreen> {
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
          height: 30,
          thickness: 1,
          indent: 15,
          endIndent: 15,
        ),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'NEAR YOU',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
    Widget CarpoolGroups = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              InkWell(
                onTap: () {
                  // Carpool 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CarpoolScreen2(),
                    ),
                  );
                },
                child: const ListTile(
                  title: Text('Carpool Group 1'),
                  subtitle: Text('Cordova - USC TC | APRIL 30, 2023 - 8:00 AM'),
                  textColor: Colors.black,
                  trailing: Icon(Icons.people),
                  tileColor: Colors.black12,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  // Carpool 2
                },
                child: const ListTile(
                  title: Text('Carpool Group 2'),
                  subtitle: Text('Looc - USC TC | APRIL 30, 2023 - 8:00 AM'),
                  textColor: Colors.black,
                  trailing: Icon(Icons.people),
                  tileColor: Colors.black12,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  // Carpool 3
                },
                child: const ListTile(
                  title: Text('Carpool Group 3'),
                  subtitle: Text('Basak - USC TC | APRIL 30, 2023 - 8:00 AM'),
                  textColor: Colors.black,
                  trailing: Icon(Icons.people),
                  tileColor: Colors.black12,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  // Carpool 4
                },
                child: const ListTile(
                  title: Text('Carpool Group 4'),
                  subtitle: Text('Babag - USC DC | APRIL 30, 2023 - 8:30 AM'),
                  textColor: Colors.black,
                  trailing: Icon(Icons.people),
                  tileColor: Colors.black12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carpool'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PinLocation,
            CarpoolGroups,
          ],
        ),
      ),
    );
  }
}
