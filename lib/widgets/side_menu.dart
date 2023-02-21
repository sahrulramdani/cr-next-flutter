import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/routing/routes.dart';
import 'package:flutter_web_course/widgets/drawer_submenu.dart';
import 'package:flutter_web_course/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(width: screenWidth / 48),
                      const SizedBox(
                        child: Image(
                            image: AssetImage(
                                'assets/images/logo_craudhah_lands.png'),
                            width: 100),
                      ),
                      SizedBox(
                        width: screenWidth / 48,
                      )
                    ],
                  ),
                ],
              ),
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((item) => SideMenuItem(
                      itemName: item.name,
                      onTap: () {
                        if (item.route == authenticationPageRoute) {
                          menuController
                              .changeActiveitemTo(overViewPageDisplayName);
                          Get.offAllNamed(authenticationPageRoute);
                        }
                        if (item.name == "Log Out") {
                          menuController
                              .changeActiveitemTo(overViewPageDisplayName);
                        } else if (!menuController.isActive(item.name)) {
                          menuController.changeActiveitemTo(item.name);
                          // if (ResponsiveWidget.isSmallScreen(context)) {
                          //   Get.back();
                          // }

                          navigationController.navigateTo(item.route);
                        }
                        const DrawerSubMenu();
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
