import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String icon;
  final String itemName;
  final Function onTap;

  const HorizontalMenuItem({Key key, this.icon, this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName)
                ? myGrey.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) ||
                      menuController.isActive(itemName),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Container(
                    width: 6,
                    height: 40,
                    color: myBlue,
                  ),
                ),
                SizedBox(
                  width: screenWidth / 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: menuController.customIcon(
                      IconData(int.parse(icon.toString()),
                          fontFamily: "MaterialIcons"),
                      itemName),
                ),
                if (!menuController.isActive(itemName))
                  Flexible(
                      child: CustomText(
                    text: itemName,
                    color:
                        menuController.isHovering(itemName) ? myBlue : myGrey,
                  ))
                else
                  Flexible(
                      child: CustomText(
                    text: itemName,
                    color: myBlue,
                    size: 18,
                    weight: FontWeight.bold,
                  ))
              ],
            ),
          )),
    );
  }
}
