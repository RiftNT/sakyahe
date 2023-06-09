import 'package:flutter/material.dart';
import 'package:sakyahe/screens/driver_register_screen.dart';
import 'package:sakyahe/widgets/custom_button.dart';

import '../widgets/custom_icontext.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/welcome_image.png",
                  height: 300,
                ),
                const SizedBox(height: 1),
                const Text(
                  "Let's get started",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Connects drivers and passengers with similar destinations to commute together on the most optimal routes.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomButton(
                          bgColor: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          text: "Register",
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          text: "Login",
                          bgColor: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 40,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DriverRegisterScreen(),
                        ),
                      );
                    },
                    text: "Work as Driver",
                    bgColor: Colors.white,
                    textColor: Colors.black,
                    leadingIcon: Icons.drive_eta,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
