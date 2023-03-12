import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/routing/routes.dart';
import 'package:get/get.dart';

class MenuControler extends GetxController {
  static MenuControler instance = Get.find();
  var activeItem = overViewPageDisplayName.obs;
  var hoverItem = "".obs;

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  // Widget returnIconFor(
  //   String icon,
  //   String itemName,
  // ) {
  //   switch (itemName) {
  //     case overViewPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //     case marketingPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //     case jamaahPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //     case inventoryPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //     case financePageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //     case purchasingPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //     case crmPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //     case hrPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //       // case ppicPageDisplayName:
  //       //   return customIcon(Icons.list_alt_outlined, itemName);
  //       // case orderPageDisplayName:
  //       //   return customIcon(Icons.shopping_cart_checkout_outlined, itemName);
  //       // case whPageDisplayName:
  //       //   return customIcon(Icons.warehouse_outlined, itemName);
  //       // case prodPageDisplayName:
  //       //   return customIcon(Icons.factory_outlined, itemName);
  //       // case qcPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);
  //     case authenticationPageDisplayName:
  //       return customIcon(
  //           IconData(int.parse(icon), fontFamily: "MaterialIcons"), itemName);

  //     default:
  //       return customIcon(Icons.exit_to_app, itemName);
  //   }
  // }

  Widget customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: myBlue,
      );
    }

    return Icon(
      icon,
      color: isHovering(itemName) ? myBlue : myGrey,
    );
  }
}
