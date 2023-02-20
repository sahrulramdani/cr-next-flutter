import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/dashboard/bar_chart_marketing.dart';
import 'package:flutter_web_course/pages/marketing/widgets/dashboard/revenue_marketing_large.dart';
import 'package:flutter_web_course/pages/marketing/widgets/dashboard/revenue_marketing_small.dart';

import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';

class MarketingDashboardPage extends StatelessWidget {
  const MarketingDashboardPage({Key key}) : super(key: key);

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
          SizedBox(
            height: 120,
            width: screenWidth,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: listCardMarketing.map((data) {
                return MyCardInfo(title: data['title'], total: data['total']);
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (!ResponsiveWidget.isSmallScreen(context))
            const ChartMarketingDash()
          else
            const RevenueMarketingSmall(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
