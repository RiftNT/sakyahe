import 'package:flutter/material.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/driver_register_screen_4.dart';

class DriverRegisterScreen3 extends StatefulWidget {
  const DriverRegisterScreen3({super.key});

  @override
  State<DriverRegisterScreen3> createState() => _DriverRegisterScreen3State();
}

class _DriverRegisterScreen3State extends State<DriverRegisterScreen3> {
  var _value = "-1";
  @override
  Widget build(BuildContext context) {
    Widget GovernmentId = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'GOVERNMENT IDs',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left, //idk ngano di mu left side
          ),
          const SizedBox(height: 50),
          DropdownButtonFormField(
            value: _value,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),
            items: const [
              DropdownMenuItem(
                child: Text(
                  "Select Government ID",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "-1",
              ),
              DropdownMenuItem(
                child: Text(
                  "SSS",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "1",
              ),
              DropdownMenuItem(
                child: Text(
                  "Philhealth",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "2",
              ),
              DropdownMenuItem(
                child: Text(
                  "Passport",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "3",
              ),
              DropdownMenuItem(
                child: Text(
                  "GSIS",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "4",
              ),
              DropdownMenuItem(
                child: Text(
                  "PRC ID",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "5",
              ),
              DropdownMenuItem(
                child: Text(
                  "Voter's ID",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "6",
              ),
              DropdownMenuItem(
                child: Text(
                  "PNP",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54),
                ),
                value: "7",
              ),
            ],
            onChanged: (v) {},
          ),
          SizedBox(height: 30),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const DriverRegisterScreen4(), //temp only
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Registration Page 3'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [GovernmentId],
        ),
      ),
    );
  }
}
