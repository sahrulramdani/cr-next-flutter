// ignore_for_file: unused_local_variable, avoid_web_libraries_in_flutter, use_build_context_synchronously, division_optimization

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

class PrintNametagKoper extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;

  const PrintNametagKoper({Key key, @required this.listPelangganJadwal})
      : super(key: key);

  @override
  State<PrintNametagKoper> createState() => _PrintNametagKoperState();
}

class _PrintNametagKoperState extends State<PrintNametagKoper> {
  List<Map<String, dynamic>> listPelanggan = [];
  List<pw.MemoryImage> gambarPelanggan = [];

  Future<void> _loadImages() async {
    for (int i = 0; i < listPelanggan.length; i++) {
      if (listPelanggan[i]['FOTO_JMAH'] != '') {
        final response = await http.get(Uri.parse(
            '$urlAddress/get-profil-koper/foto/${listPelanggan[i]['FOTO_JMAH']}'));
        final bytes = response.bodyBytes;
        final image = pw.MemoryImage(bytes);
        setState(() {
          gambarPelanggan.add(image);
        });
      } else {
        final response = await http.get(Uri.parse(
            'https://t4.ftcdn.net/jpg/02/01/98/73/360_F_201987380_YjR3kPM0PS3hF7Wvn7IBMmW1FWrMwruL.jpg'));
        final bytes = response.bodyBytes;
        final image = pw.MemoryImage(bytes);
        setState(() {
          gambarPelanggan.add(image);
        });
      }
    }
  }

  Future<void> _createPDF() async {
    ByteData byteData =
        await rootBundle.load('assets/images/nametag_koper_background.png');
    Uint8List logoByte = byteData.buffer.asUint8List();
    final background = pw.MemoryImage(logoByte);

    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    const double lebarCm = 5.5;
    final double lebarPx = lebarCm / 2.54 * 96 * devicePixelRatio;

    const double tinggiCm = 3.5;
    final double tinggiPx = tinggiCm / 2.54 * 96 * devicePixelRatio;

    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    final ttf = pw.Font.ttf(font);

    int pages = (listPelanggan.length / 4).toInt() + 1;
    int arrData = 0;
    // Maksimal index data
    int maxData = listPelanggan.length;

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
                          pw.Container(
                              child: pw.GridView(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 5.4 / 17,
                                  children: [
                                for (var i = (arrData + ((a - 1) * 4));
                                    i < (a != pages ? (a * 4) : maxData);
                                    i++)
                                  pw.Container(
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColors.black),
                                      ),
                                      child: pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Container(
                                              width: 240,
                                              padding:
                                                  const pw.EdgeInsets.all(10),
                                              decoration: pw.BoxDecoration(
                                                  image: pw.DecorationImage(
                                                image: background,
                                                fit: pw.BoxFit.cover,
                                              )),
                                              child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                        listPelanggan[i]
                                                            ['NAMA_LGKP'],
                                                        style: pw.TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .bold)),
                                                    pw.SizedBox(
                                                      height: 70,
                                                    ),
                                                    pw.Text('Nomor Paspor :',
                                                        style: pw.TextStyle(
                                                            fontSize: 13,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .bold,
                                                            color: const PdfColor
                                                                    .fromInt(
                                                                0xffffffff))),
                                                    pw.Text(
                                                        listPelanggan[i]
                                                            ['NOXX_PSPR'],
                                                        style: pw.TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .bold,
                                                            color: const PdfColor
                                                                    .fromInt(
                                                                0xffffffff))),
                                                  ]),
                                            ),
                                            pw.Container(
                                              width: 245,
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border.all(
                                                      color: PdfColors.black),
                                                  image: pw.DecorationImage(
                                                    image: gambarPelanggan[i],
                                                    fit: pw.BoxFit.cover,
                                                  )),
                                            )
                                          ]))
                              ]))
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
      ..setAttribute("download", "nametag_koper.pdf")
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

        await _loadImages();

        if (listPelanggan.isNotEmpty) {
          _createPDF();
        } else {
          showDialog(
              context: context, builder: (context) => const ModalDataFail());
        }
      },
      icon: const Icon(Icons.badge_outlined),
      label: const Text(
        'NameTag Koper',
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
