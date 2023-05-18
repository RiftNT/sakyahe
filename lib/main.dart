import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sakyahe/screens/home_screen.dart';
import 'package:sakyahe/screens/login_screen.dart';
import 'package:sakyahe/screens/nav.dart';
import 'package:sakyahe/screens/navDriver.dart';
import 'package:sakyahe/screens/otp_screen.dart';
import 'package:sakyahe/screens/profile_screen.dart';
import 'package:sakyahe/screens/register_screen.dart';
import 'package:sakyahe/screens/user_info_screen.dart';
import 'package:sakyahe/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        'welcome': (context) => const WelcomeScreen(),
        'register': (context) => const RegisterScreen(),
        'login': (context) => const LoginScreen(),
        'otp': (context) => OtpScreen(phoneNumber: '', verify: ''),
        'uinfo': (context) => const UserInfoScreen(),
        'nav': (context) => const NavScreen(),
        'navDriver': (context) => const NavDriverScreen(),
        'profile': (context) => const ProfileScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuthState();
  }

  void checkAuthState() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      final User user = auth.currentUser!;
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      String userType = snapshot.get('type');

      if (userType == 'driver') {
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacementNamed(context, 'navDriver');
        });
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacementNamed(context, 'nav');
        });
      }
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, 'welcome');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
