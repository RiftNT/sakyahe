import 'package:flutter/material.dart';
import 'package:sakyahe/screens/welcome_screen.dart';
import 'package:sakyahe/widgets/custom_button.dart';

class DriverRegisterScreen5 extends StatefulWidget {
  const DriverRegisterScreen5({super.key});

  @override
  State<DriverRegisterScreen5> createState() => _DriverRegisterScreen5State();
}

class _DriverRegisterScreen5State extends State<DriverRegisterScreen5> {
  @override
  Widget build(BuildContext context) {
    Widget Verification = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          SizedBox(height: 200),
          const Text(
            'WE\'RE VERIFYING YOU ACCOUNT!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          const Text(
            'Please expect an SMS within 24 hours on the status of your verification.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: CustomButton(
              bgColor: Colors.blue,
              textColor: Colors.white,
              text: "Done",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const WelcomeScreen(), //temp only
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
        title: const Text('Driver Registration Page 5'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Verification],
        ),
      ),
    );
  }
}
