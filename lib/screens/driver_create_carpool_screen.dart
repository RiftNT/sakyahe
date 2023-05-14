import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Carpool Group'),
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Set Pick-Up and Drop-Off',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Footer
          Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DriverCarpoolScreen(),
                  ),
                );
              },
              child: const Text(
                'Create Carpool Group',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
