import 'dart:io';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExportAgency extends StatelessWidget {
  final List<Map<String, dynamic>> listAgency;

  const ExportAgency({
    Key key,
    @required this.listAgency,
  }) : super(key: key);

  Future<void> _createExport() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('ID Marketing');
    sheet.getRangeByName('B1').setText('Nama');
    sheet.getRangeByName('C1').setText('Fee Level');
    sheet.getRangeByName('D1').setText('Periode');
    sheet.getRangeByName('E1').setText('Total');
    sheet.getRangeByName('F1').setText('Poin');

    int x = 2;
    for (var i = 0; i < listAgency.length; i++) {
      sheet
          .getRangeByName('A$x')
          .setText(listAgency[i]['id_marketing'].toString());
      sheet
          .getRangeByName('B$x')
          .setText(listAgency[i]['nama_lengkap'].toString());
      sheet.getRangeByName('C$x').setText(listAgency[i]['mk'].toString());
      sheet
          .getRangeByName('D$x')
          .setText(listAgency[i]['periode_pelanggan'].toString());
      sheet
          .getRangeByName('E$x')
          .setText(listAgency[i]['total_pelanggan'].toString());
      sheet.getRangeByName('F$x').setText(listAgency[i]['poin'].toString());
      x++;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "daftar_agency.xlsx")
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _createExport();
      },
      icon: const Icon(Icons.download_outlined),
      label: const Text(
        'Export',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }
}
