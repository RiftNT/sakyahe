import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sakyahe/screens/carpool_screen_2.dart';
import 'package:sakyahe/screens/driver_carpool_screen.dart';

import 'archive_screen.dart';
import 'driver_carpool_screen2.dart';
import 'driver_create_carpool_screen.dart';

class CarpoolScreen extends StatefulWidget {
  const CarpoolScreen({super.key});

  @override
  State<CarpoolScreen> createState() => _CarpoolScreenState();
}

class _CarpoolScreenState extends State<CarpoolScreen> {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final GlobalKey _flexibleKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Widget CarpoolGroups = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'NEAR YOU',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Archive:',
                style: TextStyle(fontSize: 16),
              ),
            ),
            leading: Icon(Icons.archive),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArchiveScreen(uid: uid),
                ),
              );
            },
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
                        .where('hasArrived', isEqualTo: false)
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
                            builder: (context, snapshot) {
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
                                          CarpoolScreen2(
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
                                    contentPadding: const EdgeInsets.symmetric(
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
                                              DateFormat('MMM d, yyyy').format(
                                                  carpool['date'].toDate()),
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
                        .where('hasArrived', isEqualTo: false)
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
                            builder: (context, snapshot) {
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
                                          CarpoolScreen2(
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
                                    contentPadding: const EdgeInsets.symmetric(
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
                                              DateFormat('MMM d, yyyy').format(
                                                  carpool['date'].toDate()),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carpool'),
        backgroundColor: Colors.blueAccent[700],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          KeyedSubtree(
            key: _flexibleKey,
            child: Flexible(
              key: UniqueKey(),
              child: CarpoolGroups,
            ),
          ),
        ],
      ),
    );
  }
}
