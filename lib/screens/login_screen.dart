import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sakyahe/screens/otp_screen.dart';
import 'package:sakyahe/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: "63",
    countryCode: "PH",
    e164Sc: 0,
    geographic: false,
    level: 1,
    name: "Philippines",
    example: "Philippines",
    displayName: "Philippines",
    displayNameNoCountryCode: "PH",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow.shade50,
                  ),
                  child: Image.asset(
                    "assets/register_image.png",
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Enter your phone number below. We will send you a verification code.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone number cannot be empty";
                      } else if (value.length != 10) {
                        return "Phone number must be exactly 10 digits";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.grey.shade600),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(22.0),
                        child: InkWell(
                          child: Text(
                            "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                            style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    text: "Next", 
                    bgColor: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final String phoneNumber = '+${selectedCountry.phoneCode}${phoneController.text}';
                          final QuerySnapshot result = await FirebaseFirestore.instance
                              .collection('users')
                              .where('phoneNumber', isEqualTo: phoneNumber)
                              .get();

                          if (result.docs.isNotEmpty) {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: phoneNumber,
                              verificationCompleted: (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent: (String verificationId, int? resendToken) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpScreen(phoneNumber: phoneNumber, verify: verificationId),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("This phone number is not registered. Please create an account."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } catch (e) {
                          print("Error checking phone number: $e");
                        }
                      }
                    },
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
