import 'package:flutter/material.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/horizontal_menu_item.dart';
import 'package:flutter_web_course/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String icon;
  final String itemName;
  final Function onTap;
  const SideMenuItem({Key key, this.icon, this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      return VerticalMenuItem(
        icon: icon,
        itemName: itemName,
        onTap: onTap,
      );
    }
    return HorizontalMenuItem(
      icon: icon,
      itemName: itemName,
      onTap: onTap,
    );
  }
}
