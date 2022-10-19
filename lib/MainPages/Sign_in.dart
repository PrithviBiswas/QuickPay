import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_pay/MainPages/homePage.dart';
import 'package:quick_pay/pages/emilVarification.dart';
import '../pages/password_reset1.dart';
import 'signup.dart';
import '../main.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({
    super.key,
  });
  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'example@gmail.com',
                    ),
                    controller: emailController,
                    cursorColor: Colors.white,
                    autofocus: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: controller,
                    obscureText: true,
                    autofocus: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: '******'),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const password_reset1()));
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 15, color: Colors.orange),
                  ),
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
                        login();
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: const Text(
                        "Login",
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
                      "Don't have an account",
                      style: TextStyle(color: Colors.white),
                    ),
                    //Text button for Sign up
                    TextButton(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignupPage()));
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

  Future login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: controller.text.trim(),
        )
        .then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const homePage())))
        .onError(
            (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                        "Invalid Email or password",
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                      backgroundColor: Colors.greenAccent),
                ));

    // navigatorKey.currentState!.popUntill((route) => route.isFirst);
  }
}
