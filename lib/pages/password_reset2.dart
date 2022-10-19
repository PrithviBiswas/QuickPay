import 'package:flutter/material.dart';

import '../MainPages/homePage.dart';

class password_reset2 extends StatefulWidget {
  const password_reset2({Key? key}) : super(key: key);

  @override
  State<password_reset2> createState() => _password_reset2State();
}

class _password_reset2State extends State<password_reset2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(top: 60.0),
        child: Center(
          child: Image(
            image: AssetImage('images/unnamed.png'),
            width: 200,
            height: 150,
          ),
        ),
      ),
      const SizedBox(
        height: 60,
      ),
      const Text(
        'Please enter your email',
      ),
      Container(
        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: const TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Code',
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Container(
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const homePage()));
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: const Text(
                  "Enter",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              )))
    ])));
  }
}
