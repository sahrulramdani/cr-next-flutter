// ignore_for_file: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/dashboard/revenue_marketing_large.dart';
import 'package:flutter_web_course/pages/marketing/widgets/dashboard/revenue_marketing_small.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';

import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';

class MarketingDashboardPage extends StatefulWidget {
  const MarketingDashboardPage({Key key}) : super(key: key);

  @override
  State<MarketingDashboardPage> createState() => _MarketingDashboardPageState();
}

class _MarketingDashboardPageState extends State<MarketingDashboardPage> {
  List<Map<String, dynamic>> listCardDashboard = [];

  void getListCardDashboard() async {
    var response = await http
        .get(Uri.parse("$urlAddress/info/dashboard/marketing"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    var dataList = {
      {
        "title": "Jamaah",
        "total": dataStatus[0]['JAMAAH'].toString(),
      },
      {
        "title": "Pusat",
        "total": dataStatus[0]['PUSAT'].toString(),
      },
      {
        "title": "Agen",
        "total": dataStatus[0]['AGENSI'].toString(),
      },
      {
        "title": "Cabang",
        "total": dataStatus[0]['CABANG'].toString(),
      },
      {
        "title": "Tour Leader",
        "total": dataStatus[0]['TOUR_LEADER'].toString(),
      },
    };

    setState(() {
      listCardDashboard = dataList.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getListCardDashboard();
  }

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
              children: listCardDashboard.map((data) {
                return MyCardInfo(title: data['title'], total: data['total']);
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (!ResponsiveWidget.isSmallScreen(context))
            const RevenueMarketingLarge()
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
