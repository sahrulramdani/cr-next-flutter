// ignore_for_file: division_optimization, unused_element

import 'dart:convert';
import "package:universal_html/html.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintNamaPelanggan extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  final String keberangkatan;
  final String jenisPaket;
  final String tglBgkt;

  const PrintNamaPelanggan({
    Key key,
    @required this.listPelangganJadwal,
    @required this.keberangkatan,
    @required this.jenisPaket,
    @required this.tglBgkt,
  }) : super(key: key);

  @override
  State<PrintNamaPelanggan> createState() => _PrintNamaPelangganState();
}

class _PrintNamaPelangganState extends State<PrintNamaPelanggan> {
  List<Map<String, dynamic>> listPelanggan = [];
  // void getPDF() async {
  Future<void> _createPDF() async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    final ttf = pw.Font.ttf(font);
    int x = 1;
    int pages = (widget.listPelangganJadwal.length / 20).toInt() + 1;
    int arrData = 0;
    int maxData = widget.listPelangganJadwal.length;

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
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text('DAFTAR NAMA PELANGGAN',
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('TOURS & TRAVEL - HAJI - UMRAH'),
                          pw.Text('Jl. SUTAATMAJA RT069/009 CIGADUNG SUBANG'),
                          pw.SizedBox(height: 20),
                          pw.SizedBox(height: 20),
                          pw.Table.fromTextArray(
                              cellPadding: const pw.EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              headers: [
                                'No.',
                                'Nama',
                              ],
                              data: <List>[
                                for (var i = (arrData + ((a - 1) * 20));
                                    i < (a != pages ? (a * 20) : maxData);
                                    i++)
                                  [
                                    (x++).toString(),
                                    widget.listPelangganJadwal[i]['NAMA_LGKP']
                                        .toString(),
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
      ..setAttribute("download", "daftar_nama_pelanggan_${widget.tglBgkt}.pdf")
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
      icon: const Icon(Icons.list_alt),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Nama Pelanggan', context),
    );
  }
}
