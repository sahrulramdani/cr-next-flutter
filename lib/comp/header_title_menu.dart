// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';

class HeaderTitleMenu extends StatelessWidget {
  String menu;
  HeaderTitleMenu({Key key, @required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
          child: CustomText(
            text: menu,
            size: 24,
            weight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
