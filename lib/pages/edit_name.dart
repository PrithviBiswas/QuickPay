import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../widgets/appbar_widget.dart';


class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    firstNameController.dispose();
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
                  width: 330,
                  child: Text(
                    "What's Your Name?",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        // Handles Form Validation for First Name
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          } else if (!isAlpha(value)) {
                            return 'Only Letters Please';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder()),
                        controller: firstNameController,
                        cursorColor: Colors.white,
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          } else if (!isAlpha(value)) {
                            return 'Only Letters Please';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        controller: secondNameController,
                        cursorColor: Colors.white,
                      ))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 50,
                        width: 330,
                        child: ElevatedButton(
                          onPressed: () {
                            updateUserValue();
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }

  Future updateUserValue() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({"name": firstNameController.text,"lastname":secondNameController.text});
        setState(() {
          
        });
  }
}
