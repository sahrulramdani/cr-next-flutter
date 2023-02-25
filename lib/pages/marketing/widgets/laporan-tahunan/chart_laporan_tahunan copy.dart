// /// Bar chart example
// // ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations, prefer_const_constructors

// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';
// import 'package:flutter_web_course/widgets/custom_text.dart';
// import 'package:flutter_web_course/widgets/revenue_info.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/constants/style.dart';

// class ChartLaporanTahunan extends StatefulWidget {
//   const ChartLaporanTahunan({Key key}) : super(key: key);

//   @override
//   State<ChartLaporanTahunan> createState() => _ChartLaporanTahunanState();
// }

// class _ChartLaporanTahunanState extends State<ChartLaporanTahunan> {
//   List<Map<String, dynamic>> listChartLaporanTahunan = [];
//   // int BULAN_JAN;
//   // int BULAN_FEB;
//   // int BULAN_MAR;
//   // int BULAN_APR;
//   // int BULAN_MEI;
//   // int BULAN_JUNI;
//   // int BULAN_JULI;
//   // int BULAN_AGUS;
//   // int BULAN_SEP;
//   // int BULAN_OKT;
//   // int BULAN_NOV;
//   // int BULAN_DES;

//   String Agen = '0';
//   String Cabang = '0';
//   String Pusat = '0';
//   String TourLeader = '0';

//   void getChart() async {
//     var response = await http
//         .get(Uri.parse("$urlAddress/chart/dashboard/laporan-tahunan"));
//     List<Map<String, dynamic>> data =
//         List.from(json.decode(response.body) as List);
//     setState(() {
//       // BULAN_JAN = data[0]['BULAN_JAN'];
//       // BULAN_FEB = data[0]['BULAN_FEB'];
//       // BULAN_MAR = data[0]['BULAN_MAR'];
//       // BULAN_APR = data[0]['BULAN_APR'];
//       // BULAN_MEI = data[0]['BULAN_MEI'];
//       listChartLaporanTahunan = data;
//     });
//     print(listChartLaporanTahunan);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getChart();
//   }

//   List<charts.Series<LinearSales, num>> _createSampleData() {
//     // final data = [
//     //   OrdinalSales('Jan', BULAN_JAN),
//     //   OrdinalSales('Feb', BULAN_FEB),
//     //   OrdinalSales('Mar', BULAN_MAR),
//     //   OrdinalSales('Apr', BULAN_APR),
//     //   OrdinalSales('Mei', BULAN_MEI),
//     // ];

//     final data = listChartLaporanTahunan.map((e) {
//       return LinearSales(e['TAHUN'], e['TOTAL']);
//     }).toList();

//     return [
//       // charts.Series<LinearSales, String>(
//       //     id: 'Sales',
//       //     colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//       //     domainFn: (LinearSales sales, _) => sales.year,
//       //     measureFn: (LinearSales sales, _) => sales.sales,
//       //     data: data,
//       //     labelAccessorFn: (LinearSales sales, _) =>
//       //         '${sales.sales.toString()}')
//       charts.Series(
//         // id: "Sales",
//         // data: data,
//         // domainFn: (LinearSales series, _) => int.parse(series.year),
//         // measureFn: (LinearSales series, _) => series.sales,
//         // colorFn: (LinearSales series, _) =>
//         //     charts.MaterialPalette.blue.shadeDefault)
//         id: 'Sales',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (LinearSales sales, _) => sales.year,
//         measureFn: (LinearSales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//               offset: const Offset(0, 6),
//               color: lightGrey.withOpacity(0.2),
//               blurRadius: 12)
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CustomText(
//                 text: "Perolehan Per Tahun ",
//                 size: 20,
//                 weight: FontWeight.bold,
//                 color: myBlue,
//               ),
//               SizedBox(
//                 width: 600,
//                 height: 450,
//                 // child: charts.BarChart(
//                 //   _createSampleData(),
//                 //   barRendererDecorator: charts.BarLabelDecorator<String>(),
//                 //   domainAxis: charts.OrdinalAxisSpec(),
//                 //   animate: true,
//                 // ),
//                 // child: charts.LineChart(
//                 //   _createSampleData(),
//                 //   animate: true,
//                 // ),
//                 child: charts.LineChart(
//                   _createSampleData(),
//                   animate: true,
//                   // primaryMeasureAxis: new charts.NumericAxisSpec(),
//                   defaultRenderer:
//                       new charts.LineRendererConfig(includePoints: true),
//                   // domainAxis: new charts.NumericAxisSpec(
//                   //     viewport: new charts.NumericExtents(2000.0, 2050.0)),
//                   behaviors: [new charts.PanAndZoomBehavior()],
//                 ),
//               )
//             ],
//           )),
//         ],
//       ),
//     );
//   }
// }

// /// Sample ordinal data type.
// class LinearSales {
//   final int year;
//   final int sales;

//   LinearSales(this.year, this.sales);
// }

// // ignore_for_file: unnecessary_new

// // /// Line chart example
// // import 'package:charts_flutter/flutter.dart' as charts;
// // import 'package:flutter/material.dart';

// // class PointsLineChart extends StatefulWidget {
// //   final List<charts.Series> seriesList;
// //   final bool animate;

// //   PointsLineChart(this.seriesList, {this.animate});

// //   /// Creates a [LineChart] with sample data and no transition.
// //   factory PointsLineChart.withSampleData() {
// //     return new PointsLineChart(
// //       _createSampleData(),
// //       // Disable animations for image tests.
// //       animate: false,
// //     );
// //   }

// //   @override
// //   State<PointsLineChart> createState() => _PointsLineChartState();

// //   /// Create one series with sample hard coded data.
// //   static List<charts.Series<LinearSales, int>> _createSampleData() {
// //     final data = [
// //       new LinearSales(0, 5),
// //       new LinearSales(1, 25),
// //       new LinearSales(2, 100),
// //       new LinearSales(3, 75),
// //     ];

// //     return [
// //       new charts.Series<LinearSales, int>(
// //         id: 'Sales',
// //         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
// //         domainFn: (LinearSales sales, _) => sales.year,
// //         measureFn: (LinearSales sales, _) => sales.sales,
// //         data: data,
// //       )
// //     ];
// //   }
// // }

// // class _PointsLineChartState extends State<PointsLineChart> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return new charts.LineChart(widget.seriesList,
// //         animate: widget.animate,
// //         defaultRenderer: new charts.LineRendererConfig(includePoints: true));
// //   }
// // }

// // /// Sample linear data type.
// // class LinearSales {
// //   final int year;
// //   final int sales;

// //   LinearSales(this.year, this.sales);
// // }
