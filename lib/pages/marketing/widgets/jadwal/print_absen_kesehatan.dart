// ignore_for_file: division_optimization

import 'dart:convert';
import "package:universal_html/html.dart";
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintAbsenKesehatan extends StatefulWidget {
  final String keberangkatan;
  final String jenisPaket;
  final String tglBgkt;
  final List<Map<String, dynamic>> listPelangganJadwal;

  const PrintAbsenKesehatan(
      {Key key,
      @required this.listPelangganJadwal,
      @required this.keberangkatan,
      @required this.tglBgkt,
      @required this.jenisPaket})
      : super(key: key);

  @override
  State<PrintAbsenKesehatan> createState() => _PrintAbsenKesehatanState();
}

class _PrintAbsenKesehatanState extends State<PrintAbsenKesehatan> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createPDF() async {
    ByteData byteData =
        await rootBundle.load('assets/images/craudhah_logo_landscape.png');
    Uint8List logoByte = byteData.buffer.asUint8List();
    final netImage = pw.MemoryImage(logoByte);

    final pdf = pw.Document();
    // Nomor Urut
    int urut = 1;
    // Jumlah Halaman
    // angka kedua maksimal data dalam satu halaman
    int pages = (listPelanggan.length / 15).toInt() + 1;
    // index data dimulai
    int arrData = 0;
    // Maksimal index data
    int maxData = listPelanggan.length;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (pw.Context context) {
          return <pw.Widget>[
            for (var a = 1; a <= pages; a++)
              pw.Wrap(
                children: <pw.Widget>[
                  pw.Container(
                      width: PdfPageFormat.a4.height,
                      child: pw.Container(
                          child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.SizedBox(
                            width: 100,
                            child: pw.Image(netImage),
                          ),
                          pw.Text('ABSEN KESEHATAN',
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                              "PEMBERANGKATAN ${widget.keberangkatan} ${widget.jenisPaket}",
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('TOURS & TRAVEL - HAJI - UMRAH'),
                          pw.Text('Jl. SUTAATMAJA RT069/009 CIGADUNG SUBANG'),
                          pw.SizedBox(height: 20),
                          pw.Table.fromTextArray(
                              cellPadding: const pw.EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              columnWidths: {
                                0: const pw.FlexColumnWidth(1),
                                1: const pw.FlexColumnWidth(4),
                                2: const pw.FlexColumnWidth(2),
                                3: const pw.FlexColumnWidth(2),
                                4: const pw.FlexColumnWidth(6),
                                5: const pw.FlexColumnWidth(6),
                              },
                              headers: [
                                'NO.',
                                'NAMA',
                                'BERAT BADAN',
                                'TENSI',
                                'RIWAYAT PENYAKIT',
                                'CATATAN',
                              ],
                              data: <List>[
                                for (var i = (arrData + ((a - 1) * 15));
                                    i < (a != pages ? (a * 15) : maxData);
                                    i++)
                                  [
                                    (urut++).toString(),
                                    listPelanggan[i]['NAMA_LGKP'].toString(),
                                    '',
                                    '',
                                    '',
                                    '',
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
    //Dispose the document
    // document.dispose();
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "absen_kesehatan_${widget.tglBgkt}.pdf")
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
          _createPDF();
        } else {
          showDialog(
              context: context, builder: (context) => const ModalDataFail());
        }
      },
      icon: const Icon(Icons.health_and_safety_outlined),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Absen Kesehatan', context),
    );
  }
}
