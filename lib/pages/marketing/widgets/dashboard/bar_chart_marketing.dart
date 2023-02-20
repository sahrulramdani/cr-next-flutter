/// Bar chart example
// ignore_for_file: unused_element, missing_return, missing_required_param

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/models/marketing_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';

import '../../../../widgets/custom_text.dart';
import '../../../../widgets/revenue_info.dart';

class ChartMarketingDash extends StatefulWidget {
  const ChartMarketingDash({Key key}) : super(key: key);

  @override
  State<ChartMarketingDash> createState() => _ChartMarketingDashState();
}

class _ChartMarketingDashState extends State<ChartMarketingDash> {
  List<MarketingModel> marketings = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var response = await http.get(Uri.parse('$urlAddress/marketing/chart'));
    List<MarketingModel> tempdata = marketingModelFromJson(response.body);
    setState(() {
      marketings = tempdata;
      loading = false;
    });
  }

  List<charts.Series<MarketingModel, String>> _createSampleData() {
    return [
      charts.Series<MarketingModel, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (MarketingModel marketingModel, _) =>
            marketingModel.NAMA_LGKP,
        measureFn: (MarketingModel marketingModel, _) =>
            marketingModel.KDXX_POSX,
        data: marketings,
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
                text: "Perolehan Jamaah",
                size: 20,
                weight: FontWeight.bold,
                color: myBlue,
              ),
              SizedBox(
                width: 600,
                height: 200,
                // child: ChartMarketingDash.withSampleData(),
                child: charts.BarChart(
                  _createSampleData(),
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
                children: const [
                  RevenueInfo(
                    title: "Karyawan",
                    amount: "240",
                  ),
                  RevenueInfo(
                    title: "Agen",
                    amount: "114",
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  RevenueInfo(
                    title: "Cabang",
                    amount: "80",
                  ),
                  RevenueInfo(
                    title: "Tour Leader",
                    amount: "42",
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

