// ignore_for_file: avoid_web_libraries_in_flutter, must_be_immutable, missing_return, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:convert';
import "package:universal_html/html.dart";
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ModalSuratKuasa extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  String tglBgkt;

  ModalSuratKuasa(
      {Key key, @required this.listPelangganJadwal, @required this.tglBgkt})
      : super(key: key);

  @override
  State<ModalSuratKuasa> createState() => _ModalSuratKuasaState();
}

class _ModalSuratKuasaState extends State<ModalSuratKuasa> {
  List<Map<String, dynamic>> listPelanggan = [];
  String NamaKantor = 'Bandung';
  String Alamat = 'Jl.Surapati No.82';

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
                                    pw.Text('Kelas 1 ${NamaKantor}'),
                                    pw.Text('${Alamat}'),
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
                                        columnWidths: {
                                          0: const pw.FlexColumnWidth(2.5),
                                          1: const pw.FlexColumnWidth(0.5),
                                          2: const pw.FlexColumnWidth(5),
                                        },
                                        data: <List>[
                                          [
                                            "",
                                            "",
                                            "",
                                          ],
                                          [
                                            "NIK",
                                            ":",
                                            listPelanggan[(a - 1)]
                                                    ['NOXX_IDNT'] ??
                                                '-'.toString(),
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
                                        columnWidths: {
                                          0: const pw.FlexColumnWidth(2.5),
                                          1: const pw.FlexColumnWidth(0.5),
                                          2: const pw.FlexColumnWidth(5),
                                        },
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
                                        'Untuk melakukan pengambilan Paspor di Kantor Imigrasi Kelas 1 ${NamaKantor}. Demikian Surat Ini dibuat untuk dipergunakan sebagaimana mestinya.'),
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
      ..setAttribute("download", "surat_kuasa_${widget.tglBgkt}.pdf")
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

  Widget inputNamaKantor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Nama Kota Kantor Imigrasi',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: NamaKantor ?? '',
      onChanged: (value) {
        NamaKantor = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Nama Kota Kantor Imigrasi tidak boleh kosong !";
        }
      },
    );
  }

  Widget inputAlamat() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Alamat Kantor Imigrasi',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      initialValue: Alamat ?? '',
      onChanged: (value) {
        Alamat = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Alamat Kantor Imigrasi tidak boleh kosong !";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth > 600 ? 300 : 300,
            height: 300,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.corporate_fare_rounded,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      FittedBox(
                        child: Text('Print Surat Kuasa',
                            style: TextStyle(
                                color: myGrey, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          inputNamaKantor(),
                          const SizedBox(height: 10),
                          inputAlamat(),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            await fncGetCek();

                            if (listPelanggan.isNotEmpty) {
                              _createPDF();
                            } else {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) => const ModalDataFail());
                            }
                          } else {
                            return null;
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Print Data',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myBlue,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
