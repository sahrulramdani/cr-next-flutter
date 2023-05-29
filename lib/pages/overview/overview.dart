import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/comp/revenue_info_large.dart';
import 'package:flutter_web_course/comp/revenue_info_small.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OverViewPage extends StatefulWidget {
  const OverViewPage({Key key}) : super(key: key);

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  List<Map<String, dynamic>> listCardDashboard = [];

  void getListCardDashboard() async {
    var response = await http
        .get(Uri.parse("$urlAddress/info/dashboard/main-dashboard"), headers: {
      'pte-token': kodeToken,
    });

    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    var dataList = {
      {
        "title": "Jamaah",
        "total": dataStatus[0]['TOTAL_JAMAAH'].toString(),
      },
      {
        "title": "Telah Berangkat",
        "total": dataStatus[0]['TLH_BGKT'].toString(),
      },
      {
        "title": "Terjadwal",
        "total": dataStatus[0]['TERJADWAL'].toString(),
      },
      {
        "title": "Progres",
        "total": dataStatus[0]['PROGRES'].toString(),
      },
    };

    setState(() {
      listCardDashboard = dataList.toList();
    });
  }

  @override
  void initState() {
    getListCardDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
        const SizedBox(height: 10),
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
          height: 15,
        ),
        Expanded(
          child: SizedBox(
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
          ),
        ),
      ],
    );
  }
}
