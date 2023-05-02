// ignore_for_file: unnecessary_import, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
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

    sheet.getRangeByName('A1').setText('ID MARKETING');
    sheet.getRangeByName('B1').setText('NAMA');
    sheet.getRangeByName('C1').setText('FEE LEVEL');
    sheet.getRangeByName('D1').setText('PERIODE');
    sheet.getRangeByName('E1').setText('TOTAL');
    sheet.getRangeByName('F1').setText('POIN');

    int x = 2;
    for (var i = 0; i < listAgency.length; i++) {
      sheet
          .getRangeByName('A$x')
          .setText(listAgency[i]['KDXX_MRKT'].toString());
      sheet
          .getRangeByName('B$x')
          .setText(listAgency[i]['NAMA_LGKP'].toString());
      sheet.getRangeByName('C$x').setText(listAgency[i]['FEE'].toString());
      sheet
          .getRangeByName('D$x')
          .setText(listAgency[i]['PERD_JMAH'].toString());
      sheet
          .getRangeByName('E$x')
          .setText(listAgency[i]['TOTL_JMAH'].toString());
      sheet
          .getRangeByName('F$x')
          .setText(listAgency[i]['TOTL_POIN'].toString());
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
        if (listAgency.isEmpty) {
          showDialog(
              context: context,
              builder: (context) => const ModalInfo(
                    deskripsi: 'Data Tidak Ada',
                  ));
        } else {
          authExpt == '1'
              ? _createExport()
              : showDialog(
                  context: context,
                  builder: (context) => const ModalInfo(
                        deskripsi: 'Anda Tidak Memiliki Akses',
                      ));
        }
      },
      icon: const Icon(Icons.download_outlined),
      label: fncLabelButtonStyle('Export', context),
      style: fncButtonAuthStyle(authExpt, context),
    );
  }
}
