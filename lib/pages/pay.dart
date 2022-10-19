import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:quick_pay/pages/confirmation.dart';
import 'package:string_validator/string_validator.dart';

class pay extends StatefulWidget {
  pay({super.key});

  @override
  State<pay> createState() => _payState();
}

class _payState extends State<pay> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        title: const Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a email.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  controller: emailController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Amount.';
                    } else if (isAlpha(value)) {
                      return 'Please enter a valid Amount';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
                      if (_formKey.currentState!.validate() &&
                          EmailValidator.validate(emailController.text) &&
                          !isAlpha(controller.text)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const confirmation()));
                      }
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
            ]),
          ),
        ),
      ),
    );
    
  }
}
