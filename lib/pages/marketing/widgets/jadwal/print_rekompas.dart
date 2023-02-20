import 'dart:io';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PrintRekompas extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;

  const PrintRekompas({Key key, @required this.listPelangganJadwal})
      : super(key: key);

  @override
  State<PrintRekompas> createState() => _PrintRekompasState();
}

class _PrintRekompasState extends State<PrintRekompas> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createPDF() async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    final ttf = pw.Font.ttf(font);
    int pages = listPelanggan.length;

    int urutx = 5807;

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
                            width: 700,
                            child: pw.Table.fromTextArray(
                                border:
                                    pw.TableBorder.all(color: PdfColors.white),
                                data: <List>[
                                  [
                                    "",
                                    "",
                                    "",
                                  ],
                                  [
                                    "Nomor",
                                    ":",
                                    "${urutx + a}/RK-JM/23",
                                  ],
                                  [
                                    "Lampiran",
                                    ":",
                                    "-",
                                  ],
                                  [
                                    "Perihal",
                                    ":",
                                    "Permohonan Pembuatan Paspor"
                                  ],
                                ]),
                          ),
                          pw.SizedBox(height: 30),
                          pw.Container(
                              width: 700,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Kepada Yth :'),
                                    pw.Text('Kepala Kantor Imigrasi'),
                                    pw.Text('Kelas 1 Bandung'),
                                    pw.Text('Jl.Surapati No.82'),
                                  ])),
                          pw.SizedBox(height: 30),
                          pw.Container(
                              width: 700,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        'Yang bertanda tangan dibawah ini : '),
                                    pw.SizedBox(height: 5),
                                    pw.Table.fromTextArray(
                                        border: pw.TableBorder.all(
                                            color: PdfColors.white),
                                        data: <List>[
                                          [
                                            "",
                                            "",
                                            "",
                                          ],
                                          [
                                            "Nama",
                                            ":",
                                            "Amim Kosasih",
                                          ],
                                          [
                                            "Jabatan",
                                            ":",
                                            "Manager Operasional PT. Cahaya Raudhah",
                                          ],
                                          [
                                            "Alamat",
                                            ":",
                                            "Jl. Sutaatmaja Rt.069/009 Cigadung - Subang",
                                          ],
                                        ]),
                                    pw.SizedBox(height: 10),
                                    pw.Text('Dengan ini menerangkan bahwa : '),
                                    pw.SizedBox(height: 5),
                                    pw.Table.fromTextArray(
                                        border: pw.TableBorder.all(
                                            color: PdfColors.white),
                                        data: <List>[
                                          [
                                            "",
                                            "",
                                            "",
                                          ],
                                          [
                                            "Nama",
                                            ":",
                                            listPelanggan[(a - 1)]['NAMA_LGKP']
                                                .toString(),
                                          ],
                                          [
                                            "Alamat",
                                            ":",
                                            listPelanggan[(a - 1)]['ALAMAT']
                                                .toString()
                                          ],
                                        ]),
                                  ])),
                          pw.SizedBox(height: 30),
                          pw.Container(
                              width: 700,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        'Adalah benar jamaah Umroh yang telah terdaftar di PT. Cahaya Raudhah dan berangkat dari Subang tanggal 27 Maret 2023. Dengan ini memberikan rekomendasi untuk Pembuatan Paspor.'),
                                  ])),
                          pw.SizedBox(height: 30),
                          pw.Container(
                              width: 700,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        'Demikian Surat Keterangan ini dibuat untuk dipergunakan sebagaimana mestinya.'),
                                  ])),
                          pw.SizedBox(height: 30),
                          pw.Container(
                              width: 700,
                              child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  children: [
                                    pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                              'Subang, ${fncGetTanggal(DateFormat("dd-MM-yyyy").format(DateTime.now()))}'),
                                          pw.SizedBox(height: 10),
                                          pw.Text('Manager Operasional',
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.Text('PT. Cahaya Raudhah',
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.SizedBox(height: 100),
                                          pw.Text('AMIM KOSASIH',
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                        ])
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
      ..setAttribute("download", "rekompas.pdf")
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
      icon: const Icon(Icons.recommend_outlined),
      label: const Text(
        'Rekomendasi Paspor',
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
