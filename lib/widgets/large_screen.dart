import 'package:flutter/material.dart';
import 'package:flutter_web_course/helpers/local_navigator.dart';
import 'package:flutter_web_course/widgets/side_menu.dart';
import 'package:flutter_web_course/constants/style.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SideMenu()),
        Expanded(
            flex: 5,
            child: Container(
                color: bgBlue,
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: localNavigator())),
      ],
    );
  }
}
