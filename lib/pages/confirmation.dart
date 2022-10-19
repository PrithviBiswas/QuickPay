import 'package:flutter/material.dart';

import '../MainPages/homePage.dart';

class confirmation extends StatelessWidget {
  const confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Text(
            'Payment Successful',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const homePage()));
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: const Text(
                  "Ok",
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
    ));
  }
}
