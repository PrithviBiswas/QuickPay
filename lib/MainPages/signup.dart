import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_pay/MainPages/Sign_in.dart';
import 'package:email_validator/email_validator.dart';
import 'package:quick_pay/MainPages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:string_validator/string_validator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    super.key,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool passcheck = false;
  final emailController = TextEditingController();
  final PassController = TextEditingController();
  final C_PassController = TextEditingController();
  final lname_controller = TextEditingController();
  final fname_controller = TextEditingController();
  late final String e;
  late final user = FirebaseAuth.instance.currentUser!;
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    PassController.dispose();
    C_PassController.dispose();
    lname_controller.dispose();
    fname_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Image(
                      image: AssetImage('images/unnamed.png'),
                      width: 200,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a first name';
                      } else if (!isAlpha(value)) {
                        return 'Enter a valid first name';
                      }
                      return null;
                    },
                    controller: fname_controller,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'First Name',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Prithvi'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a last name';
                      } else if (!isAlpha(value)) {
                        return 'Enter a valid Lastname';
                      }
                      return null;
                    },
                    controller: lname_controller,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'LastName',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Biswas'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      } else if (!EmailValidator.validate(value)) {
                        return 'enter a valid email';
                      }
                      return null;
                    },
                    controller: emailController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'example@gmail.com'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: PassController,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a password';
                      } else if (value.length < 8) {
                        return 'Enter at least 8 charaters';
                      }
                      return null;
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter secure password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the password';
                      } else if (PassController.text != value) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                    controller: C_PassController,
                    cursorColor: Colors.white,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                        SignUp();
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const Sign_in()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future SignUp() async {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: PassController.text.trim());
      String id = user.uid;
      storeData(fname_controller.text.trim(), emailController.text.trim(),
          PassController.text.trim(), id, lname_controller.text.trim());
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              "Email Already in use",
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
            backgroundColor: Colors.greenAccent),
      );
    }
  }

  Future storeData(String name, String email, String password, String uid,
      String lname) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'lastname': lname,
      'email': email,
      'password': password,
      "balance": 0,
      "uid": uid
    }).then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const homePage())))
    .onError((error, stackTrace) =>ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                        "Error occoured or no internet connection",
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                      backgroundColor: Colors.greenAccent),
                ));
  }
}
