// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/widgets/revenue_info.dart';
import 'package:flutter_web_course/comp/chart_example.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class RevenueFinanceLarge extends StatefulWidget {
  const RevenueFinanceLarge({Key key}) : super(key: key);

  @override
  State<RevenueFinanceLarge> createState() => _RevenueFinanceLargeState();
}

class _RevenueFinanceLargeState extends State<RevenueFinanceLarge> {
  int BULAN_JAN;
  int BULAN_FEB;
  int BULAN_MAR;
  int BULAN_APR;
  int BULAN_MEI;
  int BULAN_JUNI;
  int BULAN_JULI;
  int BULAN_AGUS;
  int BULAN_SEP;
  int BULAN_OKT;
  int BULAN_NOV;
  int BULAN_DES;

  String BulanIni = '0';
  String BulanLalu = '0';
  String SampaiBulanIni = '0';
  String TahunLalu = '0';

  void getChart() async {
    var response = await http
        .get(Uri.parse("$urlAddress/chart/dashboard/finance"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      BULAN_JAN = data[0]['BULAN_JAN'];
      BULAN_FEB = data[0]['BULAN_FEB'];
      BULAN_MAR = data[0]['BULAN_MAR'];
      BULAN_APR = data[0]['BULAN_APR'];
      BULAN_MEI = data[0]['BULAN_MEI'];
      BULAN_JUNI = data[0]['BULAN_JUNI'];
      BULAN_JULI = data[0]['BULAN_JULI'];
      BULAN_AGUS = data[0]['BULAN_AGUS'];
      BULAN_SEP = data[0]['BULAN_SEP'];
      BULAN_OKT = data[0]['BULAN_OKT'];
      BULAN_NOV = data[0]['BULAN_NOV'];
      BULAN_DES = data[0]['BULAN_DES'];
    });
  }

  void getFinance() async {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    var response = await http
        .get(Uri.parse("$urlAddress/data/dashboard/finance"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      BulanIni = myFormat.format(data[0]['BULAN_INI']);
      BulanLalu = myFormat.format(data[0]['BULAN_LALU']);
      SampaiBulanIni = myFormat.format(data[0]['TOTAL_BAYAR']);
      TahunLalu = myFormat.format(data[0]['TAHUN_LALU']);
    });
  }

  @override
  void initState() {
    getFinance();
    getChart();
    super.initState();
  }

  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('Jan', BULAN_JAN),
      OrdinalSales('Feb', BULAN_FEB),
      OrdinalSales('Mar', BULAN_MAR),
      OrdinalSales('Apr', BULAN_APR),
      OrdinalSales('Mei', BULAN_MEI),
      OrdinalSales('Jun', BULAN_JUNI),
      OrdinalSales('Jul', BULAN_JULI),
      OrdinalSales('Agu', BULAN_AGUS),
      OrdinalSales('Sep', BULAN_SEP),
      OrdinalSales('Okt', BULAN_OKT),
      OrdinalSales('Nov', BULAN_NOV),
      OrdinalSales('Des', BULAN_DES),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => (sales.year).toString(),
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
        // labelAccessorFn: (OrdinalSales sales, _) => sales.sales.toString(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(0.2),
              blurRadius: 12)
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: "Pendapatan ${DateFormat("yyyy").format(DateTime.now())}",
                size: 20,
                weight: FontWeight.bold,
                color: myBlue,
              ),
              SizedBox(
                width: 600,
                height: 200,
                child: charts.BarChart(
                  _createSampleData(),
                  barRendererDecorator: charts.BarLabelDecorator<String>(),
                  domainAxis: const charts.OrdinalAxisSpec(),
                  animate: true,
                ),
              )
            ],
          )),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  RevenueInfo(
                    title: "Bulan Ini",
                    amount: BulanIni,
                  ),
                  RevenueInfo(
                    title: "Bulan Lalu",
                    amount: BulanLalu,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  RevenueInfo(
                    title: "Sampai Bulan Ini",
                    amount: SampaiBulanIni,
                  ),
                  RevenueInfo(
                    title: "Tahun lalu",
                    amount: TahunLalu,
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
