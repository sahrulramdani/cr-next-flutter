// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import "package:universal_html/html.dart";
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintSertifikat extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  final String jenisPaket;
  final String tglBgkt;
  final String tglPlng;

  const PrintSertifikat(
      {Key key,
      @required this.listPelangganJadwal,
      @required this.jenisPaket,
      @required this.tglBgkt,
      @required this.tglPlng})
      : super(key: key);

  @override
  State<PrintSertifikat> createState() => _PrintSertifikatState();
}

class _PrintSertifikatState extends State<PrintSertifikat> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createPDF() async {
    final pdf = pw.Document();
    // final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    // final ttf = pw.Font.ttf(font);
    int pages = listPelanggan.length;

    var bulan = DateFormat('MM').format(DateTime.now());
    var gettahun = DateFormat("yyyy").format(DateTime.now());
    var tahun = gettahun.toString().substring(2, 4);

    var tgl_berangkat = widget.tglBgkt.toString().substring(0, 2);
    var tgl_plng = widget.tglPlng.toString().substring(0, 2);
    var bulan_tahun = fncGetTanggal(widget.tglPlng);
    var bulanplng = bulan_tahun.toString().substring(3, 6);
    var tahunplng = bulan_tahun.toString().substring(6, 11);

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
                      width: PdfPageFormat.a4.width,
                      child: pw.Container(
                          child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.SizedBox(height: 50),
                          // ${fncGetTanggal(DateFormat("dd-MM-yyyy").format(DateTime.now()))}
                          pw.Row(children: [
                            pw.SizedBox(width: 450, height: 30),
                            pw.Text(
                                'NO : ${a.toString().padLeft(3, '0')}/CR-EX/$bulan/$tahun',
                                style: pw.TextStyle(
                                    fontSize: 13,
                                    fontStyle: pw.FontStyle.italic,
                                    fontWeight: pw.FontWeight.bold)),
                          ]),

                          pw.SizedBox(height: 30),
                          pw.SizedBox(height: 30),
                          pw.SizedBox(height: 30),
                          pw.SizedBox(height: 40),
                          pw.Text(
                              listPelanggan[(a - 1)]['NAMA_LGKP'].toString(),
                              style: pw.TextStyle(
                                  fontSize: 30,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 40),
                          pw.Text(widget.jenisPaket.toUpperCase(),
                              style: pw.TextStyle(
                                fontSize: 15,
                                fontStyle: pw.FontStyle.italic,
                              )),
                          pw.SizedBox(height: 40),
                          pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text("${tgl_berangkat} s/d ${tgl_plng}",
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontStyle: pw.FontStyle.italic)),
                                pw.Text(" $bulanplng $tahunplng",
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontStyle: pw.FontStyle.italic)),
                              ])
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
      ..setAttribute("download", "sertifikat_${widget.tglBgkt}.pdf")
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
      icon: const Icon(Icons.quick_contacts_mail),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Sertifikat', context),
    );
  }
}
