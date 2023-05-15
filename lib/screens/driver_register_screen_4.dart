import 'package:flutter/material.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/driver_register_screen_5.dart';

class DriverRegisterScreen4 extends StatefulWidget {
  const DriverRegisterScreen4({super.key});

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
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
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
              text: "Next",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const DriverRegisterScreen5(), //temp only
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
