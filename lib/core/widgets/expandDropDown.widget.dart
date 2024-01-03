import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExpandDropDown extends StatefulWidget {
  final Widget title;
  final Widget child;
  // final Map<String, String> child;
  ExpandDropDown({required this.title, required this.child});
  @override
  _ExpandDropDownState createState() =>
      _ExpandDropDownState(title: title, child: child);
}

class _ExpandDropDownState extends State<ExpandDropDown>
    with TickerProviderStateMixin {
  Widget title;
  final Widget child;
  _ExpandDropDownState({required this.title, required this.child});

  bool expand1 = false;
  AnimationController? controller1;
  Animation<double>? animation1, animation1View;

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    animation1 = Tween(begin: 0.0, end: 180.0).animate(controller1!);
    animation1View = CurvedAnimation(parent: controller1!, curve: Curves.linear);

    controller1!.addListener(() {
      setState(() {});
    });
  }

  Widget buildPanel1() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      margin: EdgeInsets.all(0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(child: title, onTap: () {
            togglePanel1();
          },),
          SizeTransition(
            sizeFactor: animation1View!,
            child: Column(
                children: [
                  child,
                ]),
          ),
        ],
      ),
    );
  }

  void togglePanel1() {
    if (!expand1) {
      controller1!.forward();
    } else {
      controller1!.reverse();
    }
    expand1 = !expand1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        child: buildPanel1());
  }
}
