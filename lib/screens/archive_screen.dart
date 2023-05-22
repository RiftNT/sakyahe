import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'driver_carpool_screen2.dart';

class ArchiveScreen extends StatefulWidget {
  final uid;

  const ArchiveScreen({required this.uid});

  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archive'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('carpool_details')
                  .where('hasArrived', isEqualTo: true)
                  .where('isDeleted', isEqualTo: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final carpoolDetails = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: carpoolDetails.length,
                  itemBuilder: (context, index) {
                    final carpool =
                        carpoolDetails[index].data() as Map<String, dynamic>;
                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('carpool_group')
                          .doc(carpool['groupID'])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!.exists &&
                            (snapshot.data! as dynamic).data()!['driverUID'] ==
                                widget.uid) {
                          String timePart =
                              carpool['time'].split('(')[1].split(')')[0];
                          String datePart = DateFormat('MMM d, yyyy')
                              .format(carpool['date'].toDate());
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DriverCarpoolScreen2(
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
                                          DateFormat('MMM d, yyyy')
                                              .format(carpool['date'].toDate()),
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
                          return SizedBox();
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
