import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_pay/MainPages/homePage.dart';

class emailVerification extends StatefulWidget {
  const emailVerification({super.key});

  @override
  State<emailVerification> createState() => _emailVerificationState();
}

class _emailVerificationState extends State<emailVerification> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), ((_) => checkEmailVerified()));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = true;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
            backgroundColor: Colors.greenAccent),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const homePage()
      : Scaffold(
          backgroundColor: Colors.indigo.shade900,
          appBar: AppBar(
            title: Text('Varify your email'),
          ),
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: const Border(
                          bottom: BorderSide(color: Colors.white),
                          top: BorderSide(color: Colors.white),
                          right: BorderSide(color: Colors.white),
                          left: BorderSide(color: Colors.white))),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      sendVerificationEmail();
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: const Text(
                      "Resend Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: const Border(
                          bottom: BorderSide(color: Colors.white),
                          top: BorderSide(color: Colors.white),
                          right: BorderSide(color: Colors.white),
                          left: BorderSide(color: Colors.white))),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    color: Colors.blue.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}
