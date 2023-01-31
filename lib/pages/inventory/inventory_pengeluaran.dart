import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/pages/inventory/widgets/pengeluaran/form_pengeluaran.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';

class InventoryPengeluaranPage extends StatefulWidget {
  const InventoryPengeluaranPage({Key key}) : super(key: key);

  @override
  State<InventoryPengeluaranPage> createState() =>
      _InventoryPengeluaranPageState();
}

class _InventoryPengeluaranPageState extends State<InventoryPengeluaranPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: 'Inventory - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 20, right: 15),
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: const PengeluaranForm()),
        ],
      ),
    );
  }
}
