import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/driver_register_screen_5.dart';

class DriverRegisterScreen4 extends StatefulWidget {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String birthDate;
  final String gender;
  final String carMake;
  final String carType;
  final String carPlateNo;
  final String carColor;
  final String carCapacity;
  final String governmentId;

  const DriverRegisterScreen4({
    super.key,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
    required this.carMake,
    required this.carType,
    required this.carPlateNo,
    required this.carColor,
    required this.carCapacity,
    required this.governmentId,
  });

  @override
  State<DriverRegisterScreen4> createState() => _DriverRegisterScreen4State();
}

class _DriverRegisterScreen4State extends State<DriverRegisterScreen4> {
  @override
  Widget build(BuildContext context) {
    Widget ScanFace = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'SCAN FACE',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left, //idk ngano di mu left side
          ),
          const Icon(
            Icons.person,
            size: 350,
            color: Colors.black26,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: CustomButton(
              bgColor: Colors.blue,
              textColor: Colors.white,
              text: "Submit",
              onPressed: () {
                Map<String, dynamic> formData = {
                  'firstName': widget.firstName,
                  'middleName': widget.middleName,
                  'lastName': widget.lastName,
                  'phoneNumber': widget.phoneNumber,
                  'birthDate': widget.birthDate,
                  'gender': widget.gender,
                  'carMake': widget.carMake,
                  'carType': widget.carType,
                  'carPlate': widget.carPlateNo,
                  'carColor': widget.carColor,
                  'carCapacity': widget.carCapacity,
                  'governmentId': widget.governmentId,
                  'userID': "",
                };

                FirebaseFirestore.instance
                    .collection('driver_details')
                    .add(formData)
                    .then((value) {
                  print('Success');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DriverRegisterScreen5()),
                  );
                }).catchError((error) {
                  print('Erro: $error');
                });
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Registration Page 4'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [ScanFace],
        ),
      ),
    );
  }
}
