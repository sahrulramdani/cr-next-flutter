/// Bar chart example
// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations, prefer_const_constructors

import 'dart:convert';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';

class ChartLaporanTahunan extends StatefulWidget {
  const ChartLaporanTahunan({Key key}) : super(key: key);

  @override
  State<ChartLaporanTahunan> createState() => _ChartLaporanTahunanState();
}

class _ChartLaporanTahunanState extends State<ChartLaporanTahunan> {
  List<Map<String, dynamic>> listChartLaporanTahunan = [];
  void getChart() async {
    var response = await http.get(
        Uri.parse("$urlAddress/chart/dashboard/laporan-tahunan"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);
    setState(() {
      listChartLaporanTahunan = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getChart();
  }

  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = listChartLaporanTahunan.map((e) {
      return OrdinalSales(e['TAHUN'], e['TOTAL']);
    }).toList();

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomText(
            text: "Perolehan Per Tahun ",
            size: 20,
            weight: FontWeight.bold,
            color: myBlue,
          ),
          Expanded(
            child: SizedBox(
              width: 600,
              // height: ResponsiveWidget.isSmallScreen(context) ? 300 : 450,
              child: charts.BarChart(
                _createSampleData(),
                barRendererDecorator: charts.BarLabelDecorator<String>(),
                domainAxis: charts.OrdinalAxisSpec(),
                animate: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final int year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

// ignore_for_file: unnecessary_new

// /// Line chart example
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';

// class PointsLineChart extends StatefulWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;

//   PointsLineChart(this.seriesList, {this.animate});

//   /// Creates a [LineChart] with sample data and no transition.
//   factory PointsLineChart.withSampleData() {
//     return new PointsLineChart(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }

//   @override
//   State<PointsLineChart> createState() => _PointsLineChartState();

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<OrdinalSales, int>> _createSampleData() {
//     final data = [
//       new OrdinalSales(0, 5),
//       new OrdinalSales(1, 25),
//       new OrdinalSales(2, 100),
//       new OrdinalSales(3, 75),
//     ];

//     return [
//       new charts.Series<OrdinalSales, int>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }
// }

// class _PointsLineChartState extends State<PointsLineChart> {
//   @override
//   Widget build(BuildContext context) {
//     return new charts.LineChart(widget.seriesList,
//         animate: widget.animate,
//         defaultRenderer: new charts.LineRendererConfig(includePoints: true));
//   }
// }

// /// Sample linear data type.
// class OrdinalSales {
//   final int year;
//   final int sales;

//   OrdinalSales(this.year, this.sales);
// }
