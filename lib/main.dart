import 'package:flutter/material.dart';
import 'package:sakyahe/screens/home_screen.dart';
import 'package:sakyahe/screens/otp_screen.dart';
import 'package:sakyahe/screens/register_screen.dart';
import 'package:sakyahe/screens/user_info_screen.dart';
import 'package:sakyahe/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(const MyApp());
  runApp(MaterialApp(
    initialRoute: 'welcome',
    debugShowCheckedModeBanner: false,
    routes: {
      'welcome': (context) => WelcomeScreen(),
      'register': (context) => RegisterScreen(),
      'otp': (context) => OtpScreen(),
      'uinfo': (context) => UserInfoScreen(),
      'home': (context) => HomeScreen()
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      title: "WelcomePage",
    );
  }
}