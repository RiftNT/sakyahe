import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sakyahe/screens/home_screen.dart';
import 'package:sakyahe/screens/nav.dart';
import 'package:sakyahe/widgets/custom_button.dart';
import 'package:sakyahe/screens/user_info_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String verify;

  const OtpScreen({Key? key, required this.phoneNumber, required this.verify}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  
  String otpCode = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(height: 120),
                const Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Enter the OTP sent from your phone number.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Pinput(
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onCompleted: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: CustomButton(
                    text: "Verify",
                    bgColor: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verify, smsCode: otpCode);
                        
                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);

                        final QuerySnapshot result = await FirebaseFirestore.instance
                              .collection('users')
                              .where('phoneNumber', isEqualTo: widget.phoneNumber)
                              .get();
                        
                        if (result.docs.isNotEmpty) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => NavScreen()),
                            (route) => false,
                          );
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => UserInfoScreen()),
                            (route) => false,
                          );
                        }
                        
                      } catch (e) {
                        print("Error wrong otp");
                      }
                      
                    },
                  ),
                ),
                // const SizedBox(height: 50),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 50,
                //   child: CustomButton(
                //     text: "Test",
                //     onPressed: () {
                //       print(widget.phoneNumber);
                //     },
                //   ),
                // ),
                const SizedBox(height: 20),
                const Text(
                  "Did not receive a code?",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Resend Code.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void verifyOtp(BuildContext context, String userOtp) {}
}
