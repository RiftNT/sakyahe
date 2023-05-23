import 'package:flutter/material.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/driver_register_screen_4.dart';

class DriverRegisterScreen3 extends StatefulWidget {
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
  final int carCapacity;

  const DriverRegisterScreen3({
    Key? key,
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
  }) : super(key: key);

  @override
  State<DriverRegisterScreen3> createState() => _DriverRegisterScreen3State();
}

class _DriverRegisterScreen3State extends State<DriverRegisterScreen3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedGovernmentId;
  var _value = "-1";

  @override
  Widget build(BuildContext context) {
    Widget governmentIdWidget = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'GOVERNMENT IDs',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 50),
            DropdownButtonFormField(
              value: _value,
              validator: (value) {
                if (value == "-1") {
                  return 'Please select a government ID';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _value = value.toString();
                  selectedGovernmentId = value.toString();
                });
              },
              items: const [
                DropdownMenuItem(
                  value: "-1",
                  child: Text(
                    "Select Government ID",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  child: Text(
                    "SSS",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  value: "SSS",
                ),
                DropdownMenuItem(
                  child: Text(
                    "Philhealth",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  value: "Philhealth",
                ),
                DropdownMenuItem(
                  child: Text(
                    "Passport",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  value: "Passport",
                ),
                DropdownMenuItem(
                  child: Text(
                    "GSIS",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  value: "GSIS",
                ),
                DropdownMenuItem(
                  child: Text(
                    "PRC ID",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  value: "PRC ID",
                ),
                DropdownMenuItem(
                  child: Text(
                    "Voter's ID",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  value: "Voter's ID",
                ),
                DropdownMenuItem(
                  child: Text(
                    "PNP",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  value: "PNP",
                ),
              ],
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const UploadVehicleRegister(),
                //   ),
                // );
              },
              child: const ListTile(
                leading: Icon(
                  Icons.camera_alt_rounded,
                  size: 27,
                  color: Colors.black26,
                ),
                title: Text(
                  'Upload Photo of Government ID',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const UploadVehicleRegister(),
                //   ),
                // );
              },
              child: const ListTile(
                leading: Icon(
                  Icons.camera_alt_rounded,
                  size: 27,
                  color: Colors.black26,
                ),
                title: Text(
                  'Upload Photo of Drivers License',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
            const SizedBox(height: 40),
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
                        builder: (context) => DriverRegisterScreen4(
                          firstName: widget.firstName,
                          middleName: widget.middleName,
                          lastName: widget.lastName,
                          phoneNumber: widget.phoneNumber,
                          gender: widget.gender,
                          birthDate: widget.birthDate,
                          carMake: widget.carMake,
                          carType: widget.carType,
                          carPlateNo: widget.carPlateNo,
                          carColor: widget.carColor,
                          carCapacity: widget.carCapacity,
                          governmentId: selectedGovernmentId!,
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
        title: const Text('Driver Registration Page 3'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [governmentIdWidget],
        ),
      ),
    );
  }
}
