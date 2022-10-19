import 'package:flutter/material.dart';

import '../widgets/appbar_widget.dart';
import 'package:email_validator/email_validator.dart';

class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade900,
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    width: 320,
                    child: Text(
                      "What's your email?",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email.';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter valid email.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Your email address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      controller: emailController,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
