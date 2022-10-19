import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_pay/widgets/appbar_widget.dart';
import '../widgets/display_image_widget.dart';
import '../pages/edit_email.dart';
import '../pages/edit_image.dart';
import '../pages/edit_name.dart';
import '../pages/edit_phone.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  String name = '', lname = '', fname = '';

  Future getCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((snapshot) async {
      {
        setState(() {
          name = snapshot['name'];
          lname = snapshot['lastname'];
          fname = name + ' ' + lname;
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
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 10,
            ),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ))),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const EditImagePage()));
                },
                child: DisplayImage(
                  imagePath:
                      'https://www.pinclipart.com/picdir/middle/181-1814767_person-svg-png-icon-free-download-profile-icon.png',
                  onPressed: () {},
                )),
            buildUserInfoDisplay(
                fname, 'Name', const EditNameFormPage(), context),
            buildUserInfoDisplay(
                '01706038173', 'Phone', const EditPhoneFormPage(), context),
            buildUserInfoDisplay(
                user.email!, 'Email', const EditEmailFormPage(), context),
          ],
        ),
      ),
    );
  }
}

Widget buildUserInfoDisplay(
        String getValue, String title, Widget editPage, BuildContext context) =>
    Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
                width: 350,
                height: 40,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                ))),
                child: Row(children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => editPage));
                          },
                          child: Text(
                            getValue,
                            style: const TextStyle(
                                fontSize: 16, height: 1.4, color: Colors.white),
                          ))),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 40.0,
                  )
                ]))
          ],
        ));
