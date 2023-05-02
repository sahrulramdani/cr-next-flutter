// ignore_for_file: division_optimization, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintJadwal extends StatelessWidget {
  final List<Map<String, dynamic>> listJadwal;

  const PrintJadwal({
    Key key,
    @required this.listJadwal,
  }) : super(key: key);

  Future<void> _createPDF() async {
    final pdf = pw.Document();
    ByteData byteData =
        await rootBundle.load('assets/images/craudhah_logo_landscape.png');
    Uint8List logoByte = byteData.buffer.asUint8List();
    final netImage = pw.MemoryImage(logoByte);
    int x = 1;
    // int pages = (listJadwal.length / 40).toInt() + 1;
    // int arrData = 0;
    // int maxData = listJadwal.length;
    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    final dateNow = DateFormat('dd-MM-yyyy').format(DateTime.now());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (pw.Context context) {
          return <pw.Widget>[
            // for (var a = 1; a <= pages; a++)
            pw.Wrap(
              children: <pw.Widget>[
                pw.Container(
                    width: PdfPageFormat.a4.width,
                    child: pw.Container(
                        child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.SizedBox(
                            width: 150,
                            child: pw.Image(netImage),
                          ),
                          pw.Expanded(child: pw.Container()),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text('Jl. Sutaatmaja Rt069/006 Cigadung',
                                    style: const pw.TextStyle(fontSize: 10)),
                                pw.Text('Subang - Jawa Barat 425116',
                                    style: const pw.TextStyle(fontSize: 10)),
                              ]),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('UPDATE SISA SEAT',
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text("Data sampai dengan $dateNow",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold)),
                              ]),
                          pw.Expanded(child: pw.Container()),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text('026-002-0990 / 081-222-700-300',
                                    style: const pw.TextStyle(fontSize: 10)),
                                pw.Text("info@cahayaraudhah.com",
                                    style: const pw.TextStyle(fontSize: 10)),
                              ]),
                        ]),
                        pw.SizedBox(height: 20),
                        pw.Table.fromTextArray(
                            headerStyle: pw.TextStyle(
                                fontSize: 6, fontWeight: pw.FontWeight.bold),
                            cellStyle: const pw.TextStyle(fontSize: 6),
                            cellPadding: const pw.EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            headers: [
                              'NO.',
                              'BERANGKAT',
                              'PROGRAM',
                              'PESAWAT',
                              'SISA SEAT',
                              'TARIF',
                            ],
                            data: <List>[
                              for (var i = 0; i < listJadwal.length; i++)
                                [
                                  (x++).toString(),
                                  listJadwal[i]['TGLX_BGKT'].toString(),
                                  "${listJadwal[i]['jenisPaket'] ?? '-'} ${listJadwal[i]['KETERANGAN'] ?? '-'}",
                                  "${listJadwal[i]['NAME_PESWT_BGKT'] ?? '-'} - ${listJadwal[i]['NAME_PESWT_PLNG'] ?? '-'}",
                                  listJadwal[i]['SISA'].toString(),
                                  myformat.format(listJadwal[i]['TARIF_PKET']),
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
      ..setAttribute("download", "daftar_jadwal.pdf")
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
