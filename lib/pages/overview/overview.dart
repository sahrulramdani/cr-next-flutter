import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/comp/revenue_info_large.dart';
import 'package:flutter_web_course/comp/revenue_info_small.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
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
            width: screenWidth,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/hero-dashboard-2.png')),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: screenHeight * 0.48,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                SizedBox(
                  height: 120,
                  width: screenWidth,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: listCardDashboard.map((data) {
                      return MyCardInfo(
                          title: data['title'], total: data['total']);
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!ResponsiveWidget.isSmallScreen(context))
                  const RevenueInfoLarge()
                else
                  const RevenueInfoSmall(),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
