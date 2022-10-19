import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../widgets/appbar_widget.dart';

class qr extends StatefulWidget {
  const qr({super.key,});

  @override
  State<qr> createState() => _qrState();
}

class _qrState extends State<qr> {

final user  = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please scan the QR code to pay',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              QrImage(
                data: user.uid,
                backgroundColor: Colors.white,
                size: 320,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
