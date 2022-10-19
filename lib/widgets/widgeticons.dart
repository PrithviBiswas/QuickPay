import 'package:flutter/material.dart';
import '/animation/fadeanimation.dart';

class iconswidget extends StatefulWidget {
  final String title;
  final IconButton child;
  final double delayanimation;
  final Color color;

  iconswidget(
      {required this.title,
      required this.child,
      required this.color,
      required this.delayanimation});

  @override
  State<iconswidget> createState() => _iconswidgetState();
}

class _iconswidgetState extends State<iconswidget> {
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeAnimation(
              delay: widget.delayanimation,
              child: Container(
                  width: we * 0.15,
                  height: we * 0.15,
                  decoration: BoxDecoration(
                      color: widget.color, // 0xFF17334E
                      borderRadius: BorderRadius.circular(40.0)),
                  child: widget.child),
            ),
          ],
        ),
        SizedBox(
          height: he * 0.01,
        ),
        FadeAnimation(
            delay: widget.delayanimation,
            child: Text(
              widget.title,
              style: const TextStyle(color: Colors.grey),
            )),
      ],
    );
  }
}
