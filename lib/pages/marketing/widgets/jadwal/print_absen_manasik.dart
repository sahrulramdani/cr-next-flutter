// ignore_for_file: division_optimization, unused_element, unnecessary_string_interpolations

import 'dart:io';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PrintAbsenManasik extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  final String keberangkatan;
  final String jenisPaket;
  final String tglBgkt;

  const PrintAbsenManasik({
    Key key,
    @required this.listPelangganJadwal,
    @required this.keberangkatan,
    @required this.jenisPaket,
    @required this.tglBgkt,
  }) : super(key: key);

  @override
  State<PrintAbsenManasik> createState() => _PrintAbsenManasikState();
}

class _PrintAbsenManasikState extends State<PrintAbsenManasik> {
  List<Map<String, dynamic>> listPelanggan = [];
  bool Status = false;
  // void getPDF() async {
  Future<void> _createPDF() async {
    if (Status == false) {
      EasyLoading.show(status: 'loading...');
    }
    ByteData byteData =
        await rootBundle.load('assets/images/craudhah_logo_landscape.png');
    Uint8List logoByte = byteData.buffer.asUint8List();
    final netImage = pw.MemoryImage(logoByte);

    final pdf = pw.Document();

    int x = 1;
    int ttd = 1;
    int pages = (widget.listPelangganJadwal.length / 20).toInt() + 1;
    int arrData = 0;
    int maxData = widget.listPelangganJadwal.length;

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
                          pw.Text('ABSENSI MANASIK KEDUA',
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                              'PEMBERANGKATAN ${widget.keberangkatan} ${widget.jenisPaket}',
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('TOURS & TRAVEL - HAJI - UMRAH'),
                          pw.Text('Jl. SUTAATMAJA RT069/009 CIGADUNG SUBANG'),
                          pw.SizedBox(height: 20),
                          pw.Table.fromTextArray(
                              cellPadding: const pw.EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              headers: [
                                'No.',
                                'Nama',
                                'Alamat',
                                'No HP/WA',
                                'No Sandal',
                                'Tanda Tangan',
                              ],
                              data: <List>[
                                for (var i = (arrData + ((a - 1) * 20));
                                    i < (a != pages ? (a * 20) : maxData);
                                    i++)
                                  [
                                    (x++).toString(),
                                    widget.listPelangganJadwal[i]['NAMA_LGKP']
                                        .toString(),
                                    widget.listPelangganJadwal[i]['ALAMAT']
                                        .toString(),
                                    widget.listPelangganJadwal[i]['NOXX_TELP']
                                        .toString(),
                                    ('-').toString(),
                                    i % 2 == 0
                                        ? '${(ttd++).toString()}'
                                        : '                            ${(ttd++).toString()}',
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
      ..setAttribute("download", "absen_manasik_${widget.tglBgkt}.pdf")
      ..click();

    setState(() {
      Status = true;
    });
    if (Status == true) {
      EasyLoading.showSuccess('Great Success!');
      EasyLoading.dismiss();
    }
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
        if (Status == false) {
          EasyLoading.show(status: 'loading...');
        }
        await fncGetCek();
        if (listPelanggan.isNotEmpty) {
          _createPDF();
        } else {
          showDialog(
              context: context, builder: (context) => const ModalDataFail());
        }
      },
      icon: const Icon(Icons.library_add_check_outlined),
      label: const Text(
        'Absen Manasik',
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
