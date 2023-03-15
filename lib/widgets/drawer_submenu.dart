import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/data_submenu.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helpers/responsiveness.dart';
import '../routing/routes.dart';

class DrawerSubMenu extends StatefulWidget {
  //final String itemNama;
  const DrawerSubMenu({Key key /*, this.itemNama*/}) : super(key: key);

  @override
  State<DrawerSubMenu> createState() => _DrawerSubMenuState();
}

class _DrawerSubMenuState extends State<DrawerSubMenu> {
  List listSubmenu = [];
  List listMenus = [];
  List<Menu> drawermenu = [];

  void getSubmenu() async {
    var response = await http.get(Uri.parse(
        "$urlAddress/menu/getSubMenu/${menuController.activeItem.value}/$username"));
    List data = List.from(json.decode(response.body) as List);

    setState(() {
      listSubmenu = data;
    });
  }

  void getListMenu() async {
    var response =
        await http.get(Uri.parse("$urlAddress/menu/getListMenu/$username"));
    List listmenu = List.from(json.decode(response.body) as List);

    setState(() {
      listMenus = listmenu;
    });
  }

  @override
  void initState() {
    getSubmenu();
    getListMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    drawermenu = [];

    for (var element in listSubmenu) {
      for (var element2 in listMenus) {
        if (element["CODE_SUBMENU"] == element2["SUBMENU_CODE"]) {
          element["children"].add(element2);
        }
      }
      drawermenu.add(Menu.fromJson(element));
    }

    return Drawer(child: _buildDrawer());
  }

  Widget _buildDrawer() {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 0),
      itemCount: drawermenu.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildDrawerHeader(drawermenu[index]);
        }
        return _buildMenuList(drawermenu[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
        thickness: 2,
      ),
    );
  }

  Widget _buildDrawerHeader(Menu headItem) {
    return DrawerHeader(
        margin: const EdgeInsets.only(bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: myBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    headItem.icon,
                    color: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              headItem.title,
              style: TextStyle(
                  color: myBlue,
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Kamu sedang berada di menu ${headItem.title}',
              style: const TextStyle(
                  color: Colors.black, fontSize: 12, fontFamily: 'Gilroy'),
            ),
          ],
        ));
  }

  Widget _buildMenuList(Menu menuItem) {
    //build the expansion tile
    double lp = 0; //left padding
    double fontSize = 18;
    if (menuItem.level == 1) {
      lp = 20;
      fontSize = 16;
    }
    if (menuItem.level == 2) {
      lp = 30;
      fontSize = 14;
    }

    if (menuItem.children.isEmpty) {
      return Builder(builder: (context) {
        return InkWell(
          child: Padding(
            padding: EdgeInsets.only(left: lp),
            child: ListTile(
              leading: Icon(
                menuItem.icon,
                color: myGrey,
              ),
              title: Text(
                menuItem.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    fontFamily: 'Gilroy',
                    color: myGrey),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              menuKode = menuItem.code;
              drawermenu = [];
              listSubmenu = [];
              listMenus = [];
            });

            if (menuItem.route == authenticationPageRoute) {
              menuController.changeActiveitemTo(overViewPageDisplayName);
              Get.offAllNamed(authenticationPageRoute);
            }
            if (menuItem.title == "Log Out") {
              menuController.changeActiveitemTo(overViewPageDisplayName);
            } else if (!menuController.isActive(menuItem.title)) {
              menuController.changeActiveitemTo(menuItem.title);
              // if (ResponsiveWidget.isSmallScreen(context)) Get.back();

              navigationController.navigateTo(menuItem.route);
            }
            Navigator.pop(context);
          },
        );
      });
    }

    return Padding(
      padding: EdgeInsets.only(left: lp),
      child: ExpansionTile(
        leading: Icon(
          menuItem.icon,
          color: myGrey,
        ),
        title: Text(
          menuItem.title,
          style: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: myGrey),
        ),
        children: menuItem.children.map(_buildMenuList).toList(),
      ),
    );
  }
}

//The Menu Model
class Menu {
  int level = 0;
  IconData icon;
  String title = "Sub Menu";
  String route = "tes";
  String code = "AAA00";
  List<Menu> children = [];
  //default constructor
  Menu(this.level, this.icon, this.title, this.route, this.children, this.code);

  //one method for  Json data
  Menu.fromJson(Map<String, dynamic> json) {
    //level
    if (json["LEVEL"] != null) {
      level = int.parse(json["LEVEL"]);
    }
    //icon
    if (json['ICON'] != null) {
      icon = IconData(int.parse(json['ICON'].toString()),
          fontFamily: 'MaterialIcons');
    }
    //title
    title = json['NAME'];

    code = json['LIST_CODE'];
    //route
    route = json['PATH'];

    //children
    if (json['children'] != null) {
      children.clear();
      //for each entry from json children add to the Node children
      json['children'].forEach((v) {
        children.add(Menu.fromJson(v));
      });
    }
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard(this.menuItem, {Key key}) : super(key: key);
  // Declare a field that holds the User
  final Menu menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard1"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Are you ready for  ${menuItem.title} ?",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
        ));
  }
}
