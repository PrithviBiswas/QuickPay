import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_pay/pages/confirmation.dart';
import 'package:string_validator/string_validator.dart';

class payment extends StatefulWidget {
  final String value;
  final Function() screenClosed;
  final bool check;
  payment(
      {super.key,
      required this.value,
      required this.screenClosed,
      required this.check});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  final String user = FirebaseAuth.instance.currentUser!.uid;

  int balance = 0, balance1 = 0;

  Future getCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .get()
        .then((snapshot) async {
      {
        setState(() {
          balance = snapshot['balance'];
        });
      }
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.value)
        .get()
        .then((snapshots) async {
      {
        setState(() {
          balance1 = snapshots['balance'];
        });
      }
    });
  }

  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        title: const Text("Pay"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    initialValue: widget.value,
                    readOnly: widget.check,
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Amount.';
                      } else if (isAlpha(value)) {
                        return 'Please enter a valid Amount';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Amount',
                    ),
                    controller: controller,
                    keyboardType: TextInputType.phone,
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
                        updateValue();
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: const Text(
                        "Confirm",
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
          ),
        ),
      ),
    );
    
  }

  Future updateValue() async {
    if (balance > int.parse(controller.text)) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user)
          .update({"balance": (balance - int.parse(controller.text))});

      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.value)
          .update({"balance": (balance1 + int.parse(controller.text))})
          .then((value) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const confirmation())))
          .onError((error, stackTrace) => print('Error${error.toString()}'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              "Not Enough Balance",
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
            backgroundColor: Colors.greenAccent),
      );
    }
  }
}
