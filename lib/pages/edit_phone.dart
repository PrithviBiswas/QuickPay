import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../widgets/appbar_widget.dart';


class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void updateUserValue(String phone) {
    String formattedPhoneNumber = "(" +
        phone.substring(0, 3) +
        ") " +
        phone.substring(3, 6) +
        "-" +
        phone.substring(6, phone.length);
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
                      "What's Your Phone Number?",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                       style: TextStyle(color: Colors.white),
                      // Handles Form Validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (isAlpha(value)) {
                          return 'Only Numbers Please';
                        } else if (value.length < 10) {
                          return 'Please enter a VALID phone number';
                        }
                        return null;
                      },
                      controller: phoneController,
                      decoration:  InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      keyboardType: TextInputType.phone,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                                Navigator.pop(context);
                            },
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
