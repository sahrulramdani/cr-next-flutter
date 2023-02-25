import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/dashboard/revenue_jamaah_large.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/dashboard/revenue_jamaah_small.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';

class JamaahDashboardPage extends StatefulWidget {
  const JamaahDashboardPage({Key key}) : super(key: key);

  @override
  State<JamaahDashboardPage> createState() => _JamaahDashboardPageState();
}

class _JamaahDashboardPageState extends State<JamaahDashboardPage> {
  List<Map<String, dynamic>> listCardDashboard = {
    {
      "title": "Jamaah",
      "total": "0",
    },
    {
      "title": "Lunas Terjadwal",
      "total": "0",
    },
    {
      "title": "Belum Lunas",
      "total": "0",
    },
    {
      "title": "Lunas Reschedule",
      "total": "0",
    },
    {
      "title": "Alumni",
      "total": "0",
    },
  }.toList();

  void getListCardDashboard() async {
    var response =
        await http.get(Uri.parse("$urlAddress/info/dashboard/jamaah"));
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    var dataList = {
      {
        "title": "Jamaah",
        "total": dataStatus[0]['ALLJAMAAH'].toString(),
      },
      {
        "title": "Lunas Terjadwal",
        "total": dataStatus[0]['LUNAS_TERJADWAL'].toString(),
      },
      {
        "title": "Belum Lunas",
        "total": dataStatus[0]['BELUM_LUNAS'].toString(),
      },
      {
        "title": "Lunas Reschedule",
        "total": dataStatus[0]['LUNAS_RESCHEDULE'].toString(),
      },
      {
        "title": "Alumni",
        "total": dataStatus[0]['ALUMNI'].toString(),
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
            const RevenueJamaahLarge()
          else
            const RevenueJamaahSmall(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
