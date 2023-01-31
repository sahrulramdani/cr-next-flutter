import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/form_pembayaran.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';

class FinancePembayaranPage extends StatefulWidget {
  const FinancePembayaranPage({Key key}) : super(key: key);

  @override
  State<FinancePembayaranPage> createState() => _FinancePembayaranPageState();
}

class _FinancePembayaranPageState extends State<FinancePembayaranPage> {
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
                      text: 'Finance - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 15, right: 15),
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
              child: const PembayaranForm()),
        ],
      ),
    );
  }
}
