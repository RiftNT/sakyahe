import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import 'carpool_screen_2.dart';

class StudentArchiveScreen extends StatefulWidget {
  final uid;

  const StudentArchiveScreen({required this.uid});

  @override
  State<StudentArchiveScreen> createState() => _StudentArchiveScreenState();
}

class _StudentArchiveScreenState extends State<StudentArchiveScreen> {
  late String currentUserID;

  @override
  void initState() {
    super.initState();
    getCurrentUserID();
  }

  void getCurrentUserID() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserID = user.uid;
    }
  }

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
                            snapshot.data!.exists) {
                          final carpoolGroupData =
                              snapshot.data!.data() as Map<String, dynamic>;

                          final List<dynamic> studentUIDs =
                              carpoolGroupData['studentUIDs'] ?? [];

                          if (studentUIDs.contains(currentUserID)) {
                            String timePart =
                                carpool['time'].split('(')[1].split(')')[0];
                            String datePart = DateFormat('MMM d, yyyy')
                                .format(carpool['date'].toDate());
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarpoolScreen2(
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
                          } else {
                            return SizedBox();
                          }
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
