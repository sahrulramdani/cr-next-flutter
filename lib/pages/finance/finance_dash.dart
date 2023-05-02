import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/pages/finance/widgets/dashboard/revenue_finance_large.dart';
import 'package:flutter_web_course/pages/finance/widgets/dashboard/revenue_finance_small.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FinanceDashboardPage extends StatefulWidget {
  const FinanceDashboardPage({Key key}) : super(key: key);

  @override
  State<FinanceDashboardPage> createState() => _FinanceDashboardPageState();
}

class _FinanceDashboardPageState extends State<FinanceDashboardPage> {
  List<Map<String, dynamic>> listCardFinance = [];

  void getListCardFinance() async {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    var response = await http
        .get(Uri.parse("$urlAddress/info/dashboard/finance"), headers: {
      'pte-token': kodeToken,
    });

    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);

    var dataList = {
      {
        "title": "Keberangkatan Bulan Ini",
        "total": dataStatus[0]['TTL_BRGKT'].toString(),
      },
      {
        "title": "Tagihan",
        "total": myFormat.format(dataStatus[0]['TGIH_THUN']),
      },
      {
        "title": "Diterima",
        "total": myFormat.format(dataStatus[0]['BAYAR_THUN']),
      },
      {
        "title": "Sisa",
        "total": myFormat.format(dataStatus[0]['SISA_TGIH']),
      },
    };

    setState(() {
      listCardFinance = dataList.toList();
    });
  }

  @override
  void initState() {
    getListCardFinance();
    super.initState();
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
              children: listCardFinance.map((data) {
                return MyCardInfo(title: data['title'], total: data['total']);
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (!ResponsiveWidget.isSmallScreen(context))
            const RevenueFinanceLarge()
          else
            const RevenueFinanceSmall(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
