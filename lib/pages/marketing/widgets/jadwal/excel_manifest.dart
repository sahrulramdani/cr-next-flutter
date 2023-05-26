// ignore_for_file: unused_element, avoid_web_libraries_in_flutter, duplicate_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import "package:universal_html/html.dart";

class ExcelManifest extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  String tglBgkt;

  ExcelManifest({
    Key key,
    @required this.listPelangganJadwal,
    @required this.tglBgkt,
  }) : super(key: key);

  @override
  State<ExcelManifest> createState() => _ExcelManifestState();
}

class _ExcelManifestState extends State<ExcelManifest> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createExport() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('NO');
    sheet.getRangeByName('B1').setText('NAME ');
    sheet.getRangeByName('C1').setText('SEX ');
    sheet.getRangeByName('D1').setText('NO PASPORT ');
    sheet.getRangeByName('E1').setText('DATE OF BIRTH ');
    sheet.getRangeByName('F1').setText('PLACE OF BIRTH ');
    sheet.getRangeByName('G1').setText('DATE OF ISSUE ');
    sheet.getRangeByName('H1').setText('DATE OF EXPIRY ');
    sheet.getRangeByName('I1').setText('ISSUNG OFFICE ');

    int x = 2;
    int y = 1;
    for (var i = 0; i < listPelanggan.length; i++) {
      sheet.getRangeByName('A$x').setText((y++).toString());
      sheet.getRangeByName('B$x').setText(listPelanggan[i]['NAMA_LGKP'] != null
          ? listPelanggan[i]['NAMA_LGKP'].toString()
          : '');
      sheet.getRangeByName('C$x').setText(listPelanggan[i]['JENS_KLMN'] != null
          ? listPelanggan[i]['JENS_KLMN'] == 'W'
              ? "F"
              : "M"
          : '');
      sheet.getRangeByName('D$x').setText(listPelanggan[i]['NOXX_PSPR'] != null
          ? listPelanggan[i]['NOXX_PSPR'].toString()
          : '');
      sheet.getRangeByName('E$x').setText(listPelanggan[i]['TGLX_LHIR'] != null
          ? fncGetTanggal(DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(listPelanggan[i]['TGLX_LHIR'])))
          : '');
      sheet.getRangeByName('F$x').setText(listPelanggan[i]['TMPT_LHIR'] != null
          ? listPelanggan[i]['TMPT_LHIR'].toString()
          : '');
      sheet.getRangeByName('G$x').setText('');
      sheet.getRangeByName('H$x').setText('');
      sheet.getRangeByName('I$x').setText('');
      x++;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "excel_manifest_${widget.tglBgkt}.xlsx")
      ..click();
  }

  fncGetCek() {
    listPelanggan = [];

    for (var i = 0; i < widget.listPelangganJadwal.length; i++) {
      if (widget.listPelangganJadwal[i]['CEK'] == true) {
        listPelanggan.add(widget.listPelangganJadwal[i]);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await fncGetCek();

        if (listPelanggan.isNotEmpty) {
          _createExport();
        } else {
          showDialog(
              context: context, builder: (context) => const ModalDataFail());
        }
      },
      icon: const Icon(Icons.system_update_tv),
      style: fncButtonAuthStyle(authExpt, context),
      label: fncLabelButtonStyle('Excel Manifest', context),
    );
  }
}
