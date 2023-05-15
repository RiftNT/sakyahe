import 'package:flutter/material.dart';
import 'package:sakyahe/screens/driver_carpool_screen2.dart';
import 'package:sakyahe/screens/driver_create_carpool_screen.dart';

class DriverCarpoolScreen extends StatefulWidget {
  const DriverCarpoolScreen({Key? key}) : super(key: key);

  @override
  _DriverCarpoolScreenState createState() => _DriverCarpoolScreenState();
}

class _DriverCarpoolScreenState extends State<DriverCarpoolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carpool'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'YOUR CARPOOL GROUPS',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateCarpoolScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            height: 0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  color: Colors.white,
                  child: Row(
                    children: const [
                      Text(
                        'TO SCHOOL:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Carpool 1
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DriverCarpoolScreen2(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      title: const Text('JDC Carpool'),
                      subtitle: const Text('Cordova - USC TC'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('June 15, 2023'),
                              Text('7:30 AM'),
                              Text('₱50/person'),
                            ],
                          ),
                          SizedBox(width: 30),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            color: Colors.grey[200],
                            child: Row(
                              children: const [
                                Icon(Icons.people),
                                SizedBox(width: 5),
                                Text('3/4'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  color: Colors.white,
                  child: Row(
                    children: const [
                      Text(
                        'FROM SCHOOL:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
