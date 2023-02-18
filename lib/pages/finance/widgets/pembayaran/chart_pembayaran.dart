/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChartPembayaran extends StatefulWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  const ChartPembayaran(this.seriesList, {this.animate, key}) : super(key: key);

  /// Creates a [BarChart] with sample data and no transition.
  factory ChartPembayaran.withSampleData() {
    return ChartPembayaran(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  State<ChartPembayaran> createState() => _ChartPembayaranState();

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('Jan', 1200),
      OrdinalSales('Feb', 1600),
      OrdinalSales('Mar', 1800),
      OrdinalSales('Apr', 750),
      OrdinalSales('May', 653),
      OrdinalSales('Jun', 870),
      OrdinalSales('Jul', 600),
      OrdinalSales('Aug', 900),
      OrdinalSales('Sep', 1300),
      OrdinalSales('Okt', 800),
      OrdinalSales('Nov', 700),
      OrdinalSales('Des', 1200),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class _ChartPembayaranState extends State<ChartPembayaran> {
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      widget.seriesList,
      animate: widget.animate,
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
