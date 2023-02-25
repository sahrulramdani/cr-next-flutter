import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/data_submenu.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';

import '../helpers/responsiveness.dart';
import '../routing/routes.dart';

class DrawerSubMenu extends StatefulWidget {
  //final String itemNama;
  const DrawerSubMenu({Key key /*, this.itemNama*/}) : super(key: key);

  @override
  State<DrawerSubMenu> createState() => _DrawerSubMenuState();
}

class _DrawerSubMenuState extends State<DrawerSubMenu> {
  List<Menu> data = [];
  //List dataList = DataSubMenu_Dashboard;
  List dataList = menuController.activeItem.value == "Dashboard"
      ? dataSubMenuDashboard
      : menuController.activeItem.value == "Marketing"
          ? dataSubMenuMarketing
          : menuController.activeItem.value == "Agency"
              ? dataSubMenuMarketing
              : menuController.activeItem.value == "Jadwal"
                  ? dataSubMenuMarketing
                  : menuController.activeItem.value == "Pemberangkatan"
                      ? dataSubMenuMarketing
                      : menuController.activeItem.value == "Tour Leader"
                          ? dataSubMenuMarketing
                          : menuController.activeItem.value ==
                                  "Perolehan Per Tahun"
                              ? dataSubMenuMarketing
                              : menuController.activeItem.value ==
                                      "Master Transit"
                                  ? dataSubMenuMarketing
                                  : menuController.activeItem.value ==
                                          "Master Hotel"
                                      ? dataSubMenuMarketing
                                      : menuController.activeItem.value ==
                                              "Master Maskapai"
                                          ? dataSubMenuMarketing
                                          : menuController.activeItem.value ==
                                                  "Jamaah"
                                              ? dataSubMenuJamaah
                                              : menuController
                                                          .activeItem.value ==
                                                      "Calon Jamaah"
                                                  ? dataSubMenuJamaah
                                                  : menuController.activeItem
                                                              .value ==
                                                          "Pendaftaran Paket"
                                                      ? dataSubMenuJamaah
                                                      : menuController
                                                                  .activeItem
                                                                  .value ==
                                                              "Daftar Jamaah"
                                                          ? dataSubMenuJamaah
                                                          : menuController
                                                                      .activeItem
                                                                      .value ==
                                                                  "Daftar Alumni"
                                                              ? dataSubMenuJamaah
                                                              : menuController
                                                                          .activeItem
                                                                          .value ==
                                                                      "Inventory"
                                                                  ? dataSubMenuInventory
                                                                  : menuController
                                                                              .activeItem
                                                                              .value ==
                                                                          "Satuan"
                                                                      ? dataSubMenuInventory
                                                                      : menuController.activeItem.value ==
                                                                              "Barang"
                                                                          ? dataSubMenuInventory
                                                                          : menuController.activeItem.value == "Pengeluaran"
                                                                              ? dataSubMenuInventory
                                                                              : menuController.activeItem.value == "Grup Barang"
                                                                                  ? dataSubMenuInventory
                                                                                  : menuController.activeItem.value == "Kirim Barang"
                                                                                      ? dataSubMenuInventory
                                                                                      : menuController.activeItem.value == "Finance"
                                                                                          ? dataSubMenuFinance
                                                                                          : menuController.activeItem.value == "Pembayaran"
                                                                                              ? dataSubMenuFinance
                                                                                              : menuController.activeItem.value == "Form Bayar"
                                                                                                  ? dataSubMenuFinance
                                                                                                  : menuController.activeItem.value == "Ujrah"
                                                                                                      ? dataSubMenuFinance
                                                                                                      : menuController.activeItem.value == "Penerbangan"
                                                                                                          ? dataSubMenuFinance
                                                                                                          : menuController.activeItem.value == "HR"
                                                                                                              ? dataSubMenuHR
                                                                                                              : menuController.activeItem.value == "Karyawan"
                                                                                                                  ? dataSubMenuHR
                                                                                                                  : menuController.activeItem.value == "PPIC"
                                                                                                                      ? DataSubMenu_PPIC
                                                                                                                      : menuController.activeItem.value == "Purchasing"
                                                                                                                          ? DataSubMenu_Purchasing
                                                                                                                          : menuController.activeItem.value == "Warehouse"
                                                                                                                              ? DataSubMenu_Warehouse
                                                                                                                              : menuController.activeItem.value == "Produksi"
                                                                                                                                  ? DataSubMenu_Produksi
                                                                                                                                  : menuController.activeItem.value == "PM"
                                                                                                                                      ? DataSubMenu_PM
                                                                                                                                      : DataSubMenu_QC;

  @override
  void initState() {
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
    super.initState();
    data[0].title = menuController.activeItem.value;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: _buildDrawer());
  }

  Widget _buildDrawer() {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildDrawerHeader(data[index]);
        }
        return _buildMenuList(data[index]);
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
  IconData icon = Icons.drive_file_rename_outline;
  String title = "Sub Menu";
  String route = "tes";
  List<Menu> children = [];
  //default constructor
  Menu(this.level, this.icon, this.title, this.route, this.children);

  //one method for  Json data
  Menu.fromJson(Map<String, dynamic> json) {
    //level
    if (json["level"] != null) {
      level = json["level"];
    }
    //icon
    if (json["icon"] != null) {
      icon = json["icon"];
    }
    //title
    title = json['title'];

    //route
    route = json['route'];

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
