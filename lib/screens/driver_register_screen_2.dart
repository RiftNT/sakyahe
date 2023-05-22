import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/driver_register_screen_3.dart';

class DriverRegisterScreen2 extends StatefulWidget {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String birthDate;
  final String gender;

  const DriverRegisterScreen2({
    Key? key,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
  }) : super(key: key);

  @override
  State<DriverRegisterScreen2> createState() => _DriverRegisterScreen2State();
}

class _DriverRegisterScreen2State extends State<DriverRegisterScreen2> {
  var _value = "-1";
  final _formKey = GlobalKey<FormState>();
  String carMake = '';
  String carType = '';
  String carPlateNo = '';
  String carColor = '';
  String carCapacity = '';

  @override
  Widget build(BuildContext context) {
    Widget vehicleInfo = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'VEHICLE REGISTRATION',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Car Make is required';
                }
                return null;
              },
              onChanged: (value) {
                carMake = value;
              },
              decoration: InputDecoration(
                hintText: "Car Make",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _value,
              validator: (value) {
                if (value == "-1") {
                  return 'Car Type is required';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _value = value.toString();
                  carType = value.toString();
                });
              },
              items: const [
                DropdownMenuItem(
                  value: "-1",
                  child: Text(
                    "Select Car Type",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "SUV",
                  child: Text(
                    "SUV",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "Van",
                  child: Text(
                    "Van",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "Sedan",
                  child: Text(
                    "Sedan",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "Pick-up",
                  child: Text(
                    "Pick-up",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Car Plate No. is required';
                }
                return null;
              },
              onChanged: (value) {
                carPlateNo = value;
              },
              decoration: InputDecoration(
                hintText: "Car Plate No.",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Car Color is required';
                }
                return null;
              },
              onChanged: (value) {
                carColor = value;
              },
              decoration: InputDecoration(
                hintText: "Car Color",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Car Capacity is required';
                }
                return null;
              },
              onChanged: (value) {
                carCapacity = value;
              },
              decoration: InputDecoration(
                hintText: "Car Capacity",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
              },
              child: const ListTile(
                leading: Icon(
                  Icons.camera_alt_rounded,
                  size: 27,
                  color: Colors.black26,
                ),
                title: Text(
                  'Upload Photo of Vehicle Registration',
                  style: TextStyle(fontSize: 13.4, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                textColor: Colors.black54,
                trailing: Icon(
                  Icons.check_circle,
                  size: 27,
                  color: Colors.black26,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: CustomButton(
                bgColor: Colors.blue,
                textColor: Colors.white,
                text: "Next",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DriverRegisterScreen3(
                          firstName: widget.firstName,
                          middleName: widget.middleName,
                          lastName: widget.lastName,
                          phoneNumber: widget.phoneNumber,
                          gender: widget.gender,
                          birthDate: widget.birthDate,
                          carMake: carMake,
                          carType: carType,
                          carPlateNo: carPlateNo,
                          carColor: carColor,
                          carCapacity: carCapacity,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Registration Page 2'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [vehicleInfo],
        ),
      ),
    );
  }
}
