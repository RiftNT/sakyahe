import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'driver_carpool_screen2.dart';
import 'driver_create_carpool_screen.dart';

class DriverCarpoolScreen extends StatefulWidget {
  const DriverCarpoolScreen({Key? key}) : super(key: key);

  @override
  _DriverCarpoolScreenState createState() => _DriverCarpoolScreenState();
}

class _DriverCarpoolScreenState extends State<DriverCarpoolScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
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
                  icon: Icon(Icons.add_circle_outline),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('carpool_details')
                        .where('route', isEqualTo: 'to school')
                        .where('isDeleted', isEqualTo: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final carpoolDetails = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: carpoolDetails.length,
                        itemBuilder: (context, index) {
                          final carpool = carpoolDetails[index].data()
                              as Map<String, dynamic>;
                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('carpool_group')
                                .doc(carpool['groupID'])
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.exists &&
                                  (snapshot.data! as dynamic)
                                          .data()!['driverUID'] ==
                                      'R4ilgpJfbtStkL8PXZ4RlX98hbD3') {
                                String timePart =
                                    carpool['time'].split('(')[1].split(')')[0];
                                String datePart = DateFormat('MMM d, yyyy')
                                    .format(carpool['date'].toDate());
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DriverCarpoolScreen2(
                                          carpooldetailsID:
                                              carpool['carpooldetailsID'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                      title: Text(carpool['name']),
                                      subtitle: Text(
                                          '${carpool['pickupLocation']} - ${carpool['dropoffLocation']}'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat('MMM d, yyyy')
                                                    .format(carpool['date']
                                                        .toDate()),
                                              ),
                                              Text(timePart),
                                              const Text('₱50/person'),
                                            ],
                                          ),
                                          const SizedBox(width: 30),
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
                                );
                              } else {
                                return SizedBox(); // Return an empty SizedBox if the condition is not met
                              }
                            },
                          );
                        },
                      );
                    },
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('carpool_details')
                        .where('route', isEqualTo: 'from school')
                        .where('isDeleted', isEqualTo: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final carpoolDetails = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: carpoolDetails.length,
                        itemBuilder: (context, index) {
                          final carpool = carpoolDetails[index].data()
                              as Map<String, dynamic>;
                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('carpool_group')
                                .doc(carpool['groupID'])
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.exists &&
                                  (snapshot.data! as dynamic)
                                          .data()!['driverUID'] == uid) {
                                String timePart =
                                    carpool['time'].split('(')[1].split(')')[0];
                                String datePart = DateFormat('MMM d, yyyy')
                                    .format(carpool['date'].toDate());
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DriverCarpoolScreen2(
                                          carpooldetailsID:
                                              carpool['carpooldetailsID'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                      title: Text(carpool['name']),
                                      subtitle: Text(
                                          '${carpool['pickupLocation']} - ${carpool['dropoffLocation']}'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat('MMM d, yyyy')
                                                    .format(carpool['date']
                                                        .toDate()),
                                              ),
                                              Text(timePart),
                                              const Text('₱50/person'),
                                            ],
                                          ),
                                          const SizedBox(width: 30),
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
                                );
                              } else {
                                return SizedBox(); // Return an empty SizedBox if the condition is not met
                              }
                            },
                          );
                        },
                      );
                    },
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
