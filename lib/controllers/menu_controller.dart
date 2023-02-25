import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/routing/routes.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
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

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overViewPageDisplayName:
        return _customIcon(Icons.dashboard_outlined, itemName);
      case marketingPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case jamaahPageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case inventoryPageDisplayName:
        return _customIcon(Icons.view_module_outlined, itemName);
      case financePageDisplayName:
        return _customIcon(Icons.calculate_outlined, itemName);
      case purchasingPageDisplayName:
        return _customIcon(Icons.price_change_outlined, itemName);
      case crmPageDisplayName:
        return _customIcon(Icons.list_alt_outlined, itemName);
      case hrPageDisplayName:
        return _customIcon(Icons.contact_page_outlined, itemName);
        // case ppicPageDisplayName:
        //   return _customIcon(Icons.list_alt_outlined, itemName);
        // case orderPageDisplayName:
        //   return _customIcon(Icons.shopping_cart_checkout_outlined, itemName);
        // case whPageDisplayName:
        //   return _customIcon(Icons.warehouse_outlined, itemName);
        // case prodPageDisplayName:
        //   return _customIcon(Icons.factory_outlined, itemName);
        // case qcPageDisplayName:
        return _customIcon(Icons.verified, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);

      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
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
