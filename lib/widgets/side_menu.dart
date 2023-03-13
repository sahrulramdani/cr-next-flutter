import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/routing/routes.dart';
import 'package:flutter_web_course/widgets/drawer_submenu.dart';
import 'package:flutter_web_course/widgets/side_menu_item.dart';
import 'package:get/get.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:http/http.dart' as http;

class SideMenu extends StatefulWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List dataMenu = [];
  String overview = " ";
  void getMenu() async {
    var response =
        await http.get(Uri.parse("$urlAddress/menu/get-module/user/$username"));
    List data = List.from(json.decode(response.body) as List);

    // var routes = new MenuItem(data)
    setState(() {
      dataMenu = data;
      overview = data[0]['MENU_NAME'].toString();
    });
  }

  @override
  void initState() {
    getMenu();
    super.initState();
  }

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
            children: dataMenu
                .map((item) => SideMenuItem(
                      icon: item['ICON_MENU'],
                      itemName: item["MENU_NAME"],
                      onTap: () {
                        if (item['PATH'].toString() == "/auth") {
                          menuController.changeActiveitemTo(overview);
                          Get.offAllNamed(item['PATH'].toString());
                        }
                        if (item['MENU_NAME'].toString() == "Log Out") {
                          menuController.changeActiveitemTo(overview);
                        } else if (!menuController
                            .isActive(item['MENU_NAME'].toString())) {
                          // print(item[0]['MENU_NAME']);
                          menuController
                              .changeActiveitemTo(item['MENU_NAME'].toString());
                          // if (ResponsiveWidget.isSmallScreen(context)) {
                          //   Get.back();
                          // }

                          navigationController
                              .navigateTo(item['PATH'].toString());
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
