import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sakyahe/screens/driver_carpool_screen.dart';

enum CarpoolRoute {
  toSchool,
  fromSchool,
}

class CreateCarpoolScreen extends StatefulWidget {
  const CreateCarpoolScreen({Key? key}) : super(key: key);

  @override
  _CreateCarpoolScreenState createState() => _CreateCarpoolScreenState();
}

class _CreateCarpoolScreenState extends State<CreateCarpoolScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  CarpoolRoute? _selectedRoute;
  TextEditingController _carpoolGroupNameController = TextEditingController();
  TextEditingController _pickupLocationController = TextEditingController();
  TextEditingController _dropoffLocationController = TextEditingController();

  Future<List<String>> _fetchLocations(String query) async {
    return ['Basak', 'Cordova', 'USC-TC', 'USC-Main'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Carpool Group'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Carpool Group Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _carpoolGroupNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter carpool group name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Carpool Route',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedRoute = CarpoolRoute.toSchool;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _selectedRoute == CarpoolRoute.toSchool
                                  ? Colors.green
                                  : null,
                        ),
                        child: const Text('To School'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedRoute = CarpoolRoute.fromSchool;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _selectedRoute == CarpoolRoute.fromSchool
                                  ? Colors.green
                                  : null,
                        ),
                        child: const Text('From School'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Set Date and Time',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showDatePicker();
                        },
                        child: const Text('Select Date'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showTimePicker();
                        },
                        child: const Text('Select Time'),
                      ),
                      Expanded(
                        child: Text(
                          _selectedDate == null || _selectedTime == null
                              ? ''
                              : DateFormat('MMM d, yyyy hh:mm a').format(
                                  DateTime(
                                      _selectedDate!.year,
                                      _selectedDate!.month,
                                      _selectedDate!.day,
                                      _selectedTime!.hour,
                                      _selectedTime!.minute)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Pickup and Dropoff Locations',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: const InputDecoration(
                        hintText: 'Enter pickup location',
                        border: OutlineInputBorder(),
                      ),
                      controller: _pickupLocationController,
                    ),
                    suggestionsCallback: (query) async {
                      return await _fetchLocations(query);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _pickupLocationController.text = suggestion;
                    },
                  ),
                  const SizedBox(height: 10),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: const InputDecoration(
                        hintText: 'Enter dropoff location',
                        border: OutlineInputBorder(),
                      ),
                      controller: _dropoffLocationController,
                    ),
                    suggestionsCallback: (query) async {
                      return await _fetchLocations(query);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _dropoffLocationController.text = suggestion;
                    },
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _createCarpoolGroup,
            child: const Text('Create Carpool Group'),
          ),
        ],
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showTimePicker() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _createCarpoolGroup() async {
    String carpoolGroupName = _carpoolGroupNameController.text;
    String pickupLocation = _pickupLocationController.text;
    String dropoffLocation = _dropoffLocationController.text;

    if (carpoolGroupName.isEmpty ||
        _selectedRoute == null ||
        _selectedDate == null ||
        _selectedTime == null ||
        pickupLocation.isEmpty ||
        dropoffLocation.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Form Incomplete'),
          content: const Text('Please fill in all the fields.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    CollectionReference carpoolGroupCollection =
        FirebaseFirestore.instance.collection('carpool_group');
    DocumentReference newCarpoolGroupRef = carpoolGroupCollection.doc();

    CollectionReference carpoolDetailsCollection =
        FirebaseFirestore.instance.collection('carpool_details');
    DocumentReference newCarpoolDetailsRef = carpoolDetailsCollection.doc();

    Map<String, dynamic> carpoolGroupData = {
      'groupID': newCarpoolGroupRef.id,
      'studentUIDs': [],
      'driverUID': currentUserId,
      'carpooldetailsID': newCarpoolDetailsRef.id,
    };

    Map<String, dynamic> carpoolDetailsData = {
      'carpooldetailsID': newCarpoolDetailsRef.id,
      'name': carpoolGroupName,
      'route':
          _selectedRoute == CarpoolRoute.toSchool ? 'to school' : 'from school',
      'date': _selectedDate,
      'time': _selectedTime.toString(),
      'pickupLocation': pickupLocation,
      'dropoffLocation': dropoffLocation,
      'isDeleted': false,
      'hasArrived': false, 
      'groupID': newCarpoolGroupRef.id,
    };

    await newCarpoolGroupRef.set(carpoolGroupData);
    await newCarpoolDetailsRef.set(carpoolDetailsData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DriverCarpoolScreen(),
      ),
    );
  }
}
