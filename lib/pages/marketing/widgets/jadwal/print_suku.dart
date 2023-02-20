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

class PrintSuku extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;

  const PrintSuku({Key key, @required this.listPelangganJadwal})
      : super(key: key);

  @override
  State<PrintSuku> createState() => _PrintSukuState();
}

class _PrintSukuState extends State<PrintSuku> {
  List<Map<String, dynamic>> listPelanggan = [];

  Future<void> _createPDF() async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    final ttf = pw.Font.ttf(font);
    int pages = listPelanggan.length;

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
                          pw.SizedBox(height: 20),
                          pw.Text('Surat Kuasa',
                              style: pw.TextStyle(
                                  fontSize: 22,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold)),
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
                                            "NIK",
                                            ":",
                                            listPelanggan[(a - 1)]['NOXX_IDNT']
                                                .toString(),
                                          ],
                                          [
                                            "Nama",
                                            ":",
                                            listPelanggan[(a - 1)]['NAMA_LGKP']
                                                .toString(),
                                          ],
                                          [
                                            "Tempat, Tanggal Lahir",
                                            ":",
                                            "${listPelanggan[(a - 1)]['TMPT_LHIR']}, ${fncGetTanggal(DateFormat("dd-MM-yyyy").format(DateTime.parse(listPelanggan[(a - 1)]['TGLX_LHIR'])))}"
                                          ],
                                        ]),
                                    pw.SizedBox(height: 10),
                                    pw.Text('Dengan ini menguasakan kepada : '),
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
                                            "NIK",
                                            ":",
                                            "3213031505730011",
                                          ],
                                          [
                                            "Nama",
                                            ":",
                                            "Yanto",
                                          ],
                                          [
                                            "Tempat, Tanggal Lahir",
                                            ":",
                                            "Subang, 15 Mei 1973",
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
                                        'Untuk melakukan pengambilan Paspor di Kantor Imigrasi Kelas 1 Bandung. Demikian Surat Ini dibuat untuk dipergunakan sebagaimana mestinya.'),
                                  ])),
                          pw.SizedBox(height: 30),
                          pw.Text(
                              'Subang, ${fncGetTanggal(DateFormat("dd-MM-yyyy").format(DateTime.now()))}'),
                          pw.SizedBox(height: 100),
                          pw.Container(
                              width: 700,
                              child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Column(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Text('Yanto'),
                                        pw.SizedBox(
                                            width: 100,
                                            child: pw.Divider(
                                                color: PdfColors.black,
                                                thickness: 1)),
                                        pw.Text('081220496992'),
                                      ],
                                    ),
                                    pw.SizedBox(width: 270),
                                    pw.Column(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Text(listPelanggan[(a - 1)]
                                                ['NAMA_LGKP']
                                            .toString()),
                                        pw.SizedBox(
                                            width: 100,
                                            child: pw.Divider(
                                                color: PdfColors.black,
                                                thickness: 1)),
                                        pw.Text(listPelanggan[(a - 1)]
                                                ['NOXX_TELP']
                                            .toString()),
                                      ],
                                    )
                                  ])),
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
      ..setAttribute("download", "surat_kuasa.pdf")
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
      icon: const Icon(Icons.filter_frames_outlined),
      label: const Text(
        'Surat Kuasa',
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
