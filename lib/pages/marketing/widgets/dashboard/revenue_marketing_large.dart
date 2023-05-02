/// Bar chart example
// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations, prefer_const_constructors

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/widgets/revenue_info.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';

class RevenueMarketingLarge extends StatefulWidget {
  const RevenueMarketingLarge({Key key}) : super(key: key);

  @override
  State<RevenueMarketingLarge> createState() => _RevenueMarketingLargeState();
}

class _RevenueMarketingLargeState extends State<RevenueMarketingLarge> {
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

  String Agen = '0';
  String Cabang = '0';
  String Pusat = '0';
  String TourLeader = '0';

  void getChart() async {
    var response = await http
        .get(Uri.parse("$urlAddress/chart/dashboard/marketing"), headers: {
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

  void getAgensi() async {
    var response = await http
        .get(Uri.parse("$urlAddress/data/dashboard/marketing"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      Agen = data[0]['AGENSI'].toString();
      Cabang = data[0]['CABANG'].toString();
      Pusat = data[0]['PUSAT'].toString();
      TourLeader = data[0]['TOUR_LEADER'].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChart();
    getAgensi();
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
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${sales.sales.toString()}')
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
                text:
                    "Perolehan Jamaah ${DateFormat("yyyy").format(DateTime.now())}",
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
                    title: "Pusat",
                    amount: "$Pusat",
                  ),
                  RevenueInfo(
                    title: "Agen",
                    amount: "$Agen",
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  RevenueInfo(
                    title: "Cabang",
                    amount: "$Cabang",
                  ),
                  RevenueInfo(
                    title: "Tour Leader",
                    amount: "$TourLeader",
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
    // return charts.BarChart(
    //   widget.seriesList,
    //   animate: widget.animate,
    // );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
