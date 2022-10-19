import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_pay/MainPages/Sign_in.dart';
import 'package:quick_pay/pages/qr_payment.dart';
import '../pages/qr_image.dart';
import 'Profile.dart';
import '../animation/fadeanimation.dart';
import '../widgets/bottomnavigation.dart';
import '../widgets/cards.dart';
import '../widgets/history.dart';
import '../widgets/widgeticons.dart';
import '../pages/pay.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final String user = FirebaseAuth.instance.currentUser!.uid;
  String name = '';
  int balance = 0;

  Future getCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .get()
        .then((snapshot) async {
      {
        setState(() {
          name = snapshot['name'];
          balance = snapshot['balance'];
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
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFF1A237E),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade900,
          elevation: 0,
          actions: [
            // custom appBar with animation ....
            FadeAnimation(
              delay: 1,
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Welcome back",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: we * 0.55,
                  ),
                  Material(
                      color: Colors.black,
                      elevation: 8,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const qr()));
                        },
                        onLongPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()));
                        },
                        child: Ink.image(
                          image: const AssetImage('images/profilejpg.jpg'),
                          height: he * 0.134,
                          width: we * 0.134,
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(
                    width: we * 0.04,
                  )
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              width: we,
              height: he,
              child: Column(
                children: <Widget>[
                  swipercard(name: name, balance: balance), // cards ..
                  // Icons custom button //
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: we * 0.063,
                      ),
                      iconswidget(
                          title: "Send",
                          color: const Color(0xFF17334E),
                          delayanimation: 1.5,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => pay()));
                            },
                            icon: const Icon(Icons.send),
                            color: Colors.blue,
                          )),
                      SizedBox(
                        width: we * 0.03,
                      ),
                      iconswidget(
                          title: "Pay",
                          color: const Color(0xFF411C2E),
                          delayanimation: 1.7,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => pay()));
                            },
                            icon: const Icon(Icons.payments),
                            color: Colors.red,
                          )),
                      SizedBox(
                        width: we * 0.03,
                      ),
                      iconswidget(
                          title: "withdraw",
                          color: const Color(0xFF163333),
                          delayanimation: 1.9,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => pay()));
                            },
                            icon: Image.asset(
                              "images/icons8-cash-withdrawal-96.png",
                              width: we * 0.08,
                              height: we * 0.08,
                              color: Colors.green,
                            ),
                          )),
                      SizedBox(width: we * 0.03),
                      iconswidget(
                          title: "Bill",
                          color: const Color(0xFF32204D),
                          delayanimation: 2.1,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const qr_payment()));
                            },
                            icon: const Icon(Icons.receipt),
                            color: Colors.purple,
                          )),
                      SizedBox(
                        width: we * 0.03,
                      ),
                      iconswidget(
                          title: "voucher",
                          color: const Color(0xFF412D27),
                          delayanimation: 2.3,
                          child: IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Image.asset(
                              "images/icons8-voucher-96.png",
                              width: we * 0.08,
                              height: he * 0.08,
                              color: Colors.orange,
                            ),
                            color: Colors.purple,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: he * 0.020,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: we * 0.063,
                      ),
                      iconswidget(
                          title: "Logout",
                          color: Colors.black38,
                          delayanimation: 2.4,
                          child: IconButton(
                            onPressed: () {
                              FirebaseAuth.instance
                                  .signOut()
                                  .then((value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Sign_in())))
                                  .onError((error, stackTrace) =>
                                      print('Error ${error.toString()}'));
                            },
                            icon: const Icon(Icons.logout_rounded),
                            color: Colors.blue,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: he * 0.05,
                  ),

                  // histories from wallet  ..  //

                  historywallet(
                      images:
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Taka_%28Bengali_letter%29.svg/1200px-Taka_%28Bengali_letter%29.svg.png",
                      title: "Salary",
                      day: "29Sep 2022",
                      postiveornagtive: "+",
                      money: " 5000.0 ৳",
                      time: "09:00 pm"),
                  SizedBox(
                    height: he * 0.02,
                  ),
                  historywallet(
                      images:
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Spotify_icon.svg/1982px-Spotify_icon.svg.png",
                      title: "Spotify Subscription",
                      day: "20Sep 2022",
                      postiveornagtive: "-",
                      money: " 100 ৳",
                      time: "12:01 am"),
                  SizedBox(
                    height: he * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:
            const boottomnavigationBar() // bottomNavigationBar custom...
        );
  }
}
