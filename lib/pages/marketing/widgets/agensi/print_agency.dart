// ignore_for_file: division_optimization, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintAgency extends StatelessWidget {
  final List<Map<String, dynamic>> listAgency;

  const PrintAgency({
    Key key,
    @required this.listAgency,
  }) : super(key: key);

  Future<void> _createPDF() async {
    final pdf = pw.Document();
    int x = 1;
    int pages = (listAgency.length / 40).toInt() + 1;
    int arrData = 0;
    int maxData = listAgency.length;
    final dateNow = DateFormat('dd-MM-yyyy').format(DateTime.now());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (pw.Context context) {
          return <pw.Widget>[
            for (var a = 1; a <= pages; a++)
              pw.Wrap(
                children: <pw.Widget>[
                  pw.Container(
                      width: PdfPageFormat.a4.width,
                      child: pw.Container(
                          child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Laporan Daftar Agency Tanggal : $dateNow',
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 30),
                          pw.Table.fromTextArray(
                              cellStyle: const pw.TextStyle(fontSize: 10),
                              cellPadding: const pw.EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              headers: [
                                'NO.',
                                'ID MARKETING',
                                'NAMA',
                                'FEE',
                                'PER',
                                'TTL',
                                'POIN',
                              ],
                              data: <List>[
                                for (var i = (arrData + ((a - 1) * 40));
                                    i < (a != pages ? (a * 40) : maxData);
                                    i++)
                                  [
                                    (x++).toString(),
                                    listAgency[i]['KDXX_MRKT'].toString(),
                                    listAgency[i]['NAMA_LGKP'].toString(),
                                    listAgency[i]['FEE'].toString(),
                                    listAgency[i]['PERD_JMAH'].toString(),
                                    listAgency[i]['TOTL_JMAH'].toString(),
                                    listAgency[i]['TOTL_POIN'].toString(),
                                  ]
                              ]),
                        ],
                      ))),
                ],
              ),
          ];
        },
      ),
    );
    Uint8List bytes = await pdf.save();
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "daftar_agency.pdf")
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
          authPrnt == '1'
              ? _createPDF()
              : showDialog(
                  context: context,
                  builder: (context) => const ModalInfo(
                        deskripsi: 'Anda Tidak Memiliki Akses',
                      ));
        }
      },
      icon: const Icon(Icons.print_outlined),
      label: fncLabelButtonStyle('Print', context),
      style: fncButtonAuthStyle(authPrnt, context),
    );
  }
}
