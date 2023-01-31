import 'package:flutter/material.dart';
import 'package:flutter_web_course/helpers/local_navigator.dart';
import 'package:flutter_web_course/constants/style.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgBlue,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: localNavigator());
  }
}
