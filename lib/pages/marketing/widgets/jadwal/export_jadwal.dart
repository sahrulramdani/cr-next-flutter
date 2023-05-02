// ignore_for_file: unnecessary_import, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExportJadwal extends StatelessWidget {
  final List<Map<String, dynamic>> listJadwal;

  const ExportJadwal({
    Key key,
    @required this.listJadwal,
  }) : super(key: key);

  Future<void> _createExport() async {
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('BERANGKAT');
    sheet.getRangeByName('B1').setText('PROGRAM');
    sheet.getRangeByName('C1').setText('PESAWAT');
    sheet.getRangeByName('D1').setText('FLIGHT SCHEDULE');
    sheet.getRangeByName('E1').setText('SISA SEAT');
    sheet.getRangeByName('F1').setText('TARIF');

    int x = 2;
    for (var i = 0; i < listJadwal.length; i++) {
      sheet
          .getRangeByName('A$x')
          .setText(listJadwal[i]['TGLX_BGKT'].toString());
      sheet.getRangeByName('B$x').setText(
          '${listJadwal[i]['jenisPaket'] ?? '-'} ${listJadwal[i]['KETERANGAN'] ?? '-'}');
      sheet.getRangeByName('C$x').setText(
          '${listJadwal[i]['NAME_PESWT_BGKT']} - ${listJadwal[i]['NAME_PESWT_PLNG']}');
      sheet
          .getRangeByName('D$x')
          .setText(listJadwal[i]['KETX_RUTE'].toString());
      sheet.getRangeByName('E$x').setText(listJadwal[i]['SISA'].toString());
      sheet
          .getRangeByName('F$x')
          .setText(myformat.format(listJadwal[i]['TARIF_PKET']));
      x++;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "daftar_jadwal.xlsx")
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (listJadwal.isEmpty) {
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
