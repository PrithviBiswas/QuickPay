import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_pay/MainPages/Sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quick_pay/MainPages/homePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'QuickPay',
    home: const MyApp(),
    navigatorKey: navigatorKey,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('opps!something went wrong'),
            );
          } else if (snapshot.hasData) {
            return const homePage();
          } else {
            return const Sign_in();
          }
        },
      ),
    );
  }
}
