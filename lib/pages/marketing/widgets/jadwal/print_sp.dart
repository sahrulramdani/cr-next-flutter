// ignore_for_file: division_optimization, unused_element, unused_local_variable, avoid_web_libraries_in_flutter, unused_import, duplicate_import, missing_return

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

class ModalSuratPernyataan extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  String tglBgkt;

  ModalSuratPernyataan(
      {Key key, @required this.listPelangganJadwal, @required this.tglBgkt})
      : super(key: key);
  @override
  State<ModalSuratPernyataan> createState() => _ModalSuratPernyataanState();
}

class _ModalSuratPernyataanState extends State<ModalSuratPernyataan> {
  List<Map<String, dynamic>> listPelanggan = [];
  TextEditingController dateKeluar = TextEditingController();
  String kotaKeluar;
  bool enableOne = false;
  bool enableTwo = false;

  Future<void> _createPDF() async {
    ByteData byteData = await rootBundle.load('assets/images/direktur.jpg');
    Uint8List logoByte = byteData.buffer.asUint8List();
    final netImage = pw.MemoryImage(logoByte);

    NumberFormat myformat = NumberFormat.decimalPattern('en_us');
    final pdf = pw.Document();

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
                          pw.Text('SURAT PERNYATAAN',
                              style: pw.TextStyle(
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 20),
                          pw.Container(
                              width: 700,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        'Yang bertanda tangan dibawah ini : ',
                                        style: const pw.TextStyle(fontSize: 9)),
                                    pw.Table.fromTextArray(
                                        cellStyle:
                                            const pw.TextStyle(fontSize: 9),
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
                                            "Tempat, Tanggal Lahir",
                                            ":",
                                            "${listPelanggan[(a - 1)]['TMPT_LHIR']}, ${fncGetTanggal(DateFormat("dd-MM-yyyy").format(DateTime.parse(listPelanggan[(a - 1)]['TGLX_LHIR'])))}"
                                          ],
                                          [
                                            "Nomor Paspor",
                                            ":",
                                            listPelanggan[(a - 1)]['NOXX_PSPR']
                                                .toString(),
                                          ],
                                        ]),
                                    pw.SizedBox(height: 5),
                                    pw.Text(
                                        'Dengan ini menyatakan bahwa, Jika saya',
                                        style: const pw.TextStyle(fontSize: 9)),
                                    //Pernyataan 1
                                    enableOne == true
                                        ? pw.Table.fromTextArray(
                                            cellStyle:
                                                const pw.TextStyle(fontSize: 9),
                                            border: pw.TableBorder.all(
                                                color: PdfColors.white),
                                            columnWidths: {
                                                0: const pw.FlexColumnWidth(
                                                    0.7),
                                                1: const pw.FlexColumnWidth(12),
                                              },
                                            data: <List>[
                                                [
                                                  "",
                                                  "",
                                                ],
                                                [
                                                  "1.",
                                                  "Ditakdirkan meninggal dunia selama mengikuti Ibadah Umroh bersama PT. Cahaya Raudhah Subang maka :",
                                                ],
                                              ])
                                        : pw.Container(),
                                    enableOne == true
                                        ? pw.Table.fromTextArray(
                                            cellStyle:
                                                const pw.TextStyle(fontSize: 9),
                                            cellPadding:
                                                const pw.EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 1),
                                            border: pw.TableBorder.all(
                                                color: PdfColors.white),
                                            columnWidths: {
                                                0: const pw.FlexColumnWidth(
                                                    0.7),
                                                1: const pw.FlexColumnWidth(
                                                    0.7),
                                                2: const pw.FlexColumnWidth(
                                                    0.3),
                                                3: const pw.FlexColumnWidth(10),
                                              },
                                            data: <List>[
                                                [
                                                  "",
                                                  "",
                                                  "",
                                                  "",
                                                ],
                                                [
                                                  "",
                                                  "",
                                                  "a.",
                                                  "Saya dan pihak keluarga yang mewakili membebaskan segala tuntutan kepada pihak Travel PT. CAHAYA RAUDHAH SUBANG.",
                                                ],
                                                [
                                                  "",
                                                  "",
                                                  "b.",
                                                  "Saya bersedia untuk dimakamkan ditempat saya meninggal dunia.",
                                                ],
                                              ])
                                        : pw.Container(),
                                    //Pernyataan 2
                                    enableTwo == true
                                        ? pw.Table.fromTextArray(
                                            cellStyle:
                                                const pw.TextStyle(fontSize: 9),
                                            border: pw.TableBorder.all(
                                                color: PdfColors.white),
                                            columnWidths: {
                                                0: const pw.FlexColumnWidth(
                                                    0.7),
                                                1: const pw.FlexColumnWidth(12),
                                              },
                                            data: <List>[
                                                [
                                                  "",
                                                  "",
                                                ],
                                                [
                                                  enableOne == true
                                                      ? "2."
                                                      : "1.",
                                                  "Mempergunakan ibadah umroh untuk kegiatan yang tidak semestinya seperti menjadi TKW / Melarikan Diri / Memisahkan diri dari rombongan umroh maka :",
                                                ],
                                              ])
                                        : pw.Container(),
                                    enableTwo == true
                                        ? pw.Table.fromTextArray(
                                            cellStyle:
                                                const pw.TextStyle(fontSize: 9),
                                            cellPadding:
                                                const pw.EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 1),
                                            border: pw.TableBorder.all(
                                                color: PdfColors.white),
                                            columnWidths: {
                                                0: const pw.FlexColumnWidth(
                                                    0.7),
                                                1: const pw.FlexColumnWidth(
                                                    0.7),
                                                2: const pw.FlexColumnWidth(
                                                    0.3),
                                                3: const pw.FlexColumnWidth(10),
                                              },
                                            data: <List>[
                                                [
                                                  "",
                                                  "",
                                                  "",
                                                  "",
                                                ],
                                                [
                                                  "",
                                                  "",
                                                  "a.",
                                                  "Saya dan pihak keluarga yang mewakili bersedia untuk dituntut sesuai hukum dan undang-undang yang berlaku.",
                                                ],
                                                [
                                                  "",
                                                  "",
                                                  "b.",
                                                  "Saya bersedia untuk membayar denda sebesar SAR 25.000 sesuai dengan undang-undang dan peraturan yang berlaku di Kerajaan Saudi Arabia (KSA)",
                                                ],
                                              ])
                                        : pw.Container(),
                                    // Pernyataan 3
                                    pw.Table.fromTextArray(
                                        cellStyle:
                                            const pw.TextStyle(fontSize: 9),
                                        border: pw.TableBorder.all(
                                            color: PdfColors.white),
                                        columnWidths: {
                                          0: const pw.FlexColumnWidth(0.7),
                                          1: const pw.FlexColumnWidth(12),
                                        },
                                        data: <List>[
                                          [
                                            "",
                                            "",
                                          ],
                                          [
                                            enableTwo == true
                                                ? (enableOne == true
                                                    ? '3'
                                                    : '2')
                                                : (enableOne == true
                                                    ? '2'
                                                    : '1'),
                                            "Apablia Swab baik di Tanah Air maupun Arab Saudi positif membebaskan travel dari segala tuntutan.",
                                          ],
                                        ]),
                                  ])),
                          pw.SizedBox(height: 5),
                          pw.Container(
                              width: 700,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                        'Demikian surat pernyataan ini saya buat dengan keadaan sehat, sadar dan tanpa ada paksaaan dari pihak manapun. Surat Pernyataan ini dibuat sebagai bukti pegangan masing-masing.',
                                        style: const pw.TextStyle(fontSize: 9)),
                                  ])),
                          pw.SizedBox(height: 10),
                          pw.Text('Subang, ${fncGetTanggal(dateKeluar.text)}',
                              style: const pw.TextStyle(fontSize: 9)),
                          pw.SizedBox(height: 5),
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
                                        pw.Text('Jamaah Umrah',
                                            style: pw.TextStyle(
                                                fontSize: 9,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.Text('PT.Cahaya Raudhah',
                                            style: pw.TextStyle(
                                                fontSize: 9,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(height: 100),
                                        pw.SizedBox(
                                            width: 70,
                                            child: pw.Divider(
                                                color: PdfColors.black,
                                                thickness: 1)),
                                      ],
                                    ),
                                    pw.SizedBox(width: 270),
                                    pw.Column(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Text('Jamaah Umrah',
                                            style: pw.TextStyle(
                                                fontSize: 9,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(height: 100),
                                        pw.SizedBox(
                                            width: 70,
                                            child: pw.Divider(
                                                color: PdfColors.black,
                                                thickness: 1)),
                                      ],
                                    )
                                  ])),
                          pw.SizedBox(height: 5),
                          pw.Container(
                              width: 700,
                              child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: [
                                    pw.Text('Direktur',
                                        style: pw.TextStyle(
                                            fontSize: 9,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Text('PT.Cahaya Raudhah',
                                        style: pw.TextStyle(
                                            fontSize: 9,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.SizedBox(
                                      height: 80,
                                      child: pw.Image(netImage),
                                    ),
                                    pw.SizedBox(
                                        width: 70,
                                        child: pw.Divider(
                                            color: PdfColors.black,
                                            thickness: 1)),
                                    pw.Text('WAWAN HERMAWAN',
                                        style: pw.TextStyle(
                                            fontSize: 9,
                                            fontWeight: pw.FontWeight.bold)),
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
      ..setAttribute("download", "surat_pernyataan_${widget.tglBgkt}.pdf")
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

  Widget inputKotaKeluar() {
    return TextFormField(
      initialValue: kotaKeluar ?? "Subang",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Kota Pengeluaran',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        kotaKeluar = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Kota Pengeluaran tidak boleh kosong !";
        }
      },
    );
  }

  Widget inputTglKeluar() {
    return TextFormField(
      controller: dateKeluar,
      decoration: const InputDecoration(
          labelText: 'Tanggal Pengeluaran',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          hintText: "DD-MM-YYYY"),
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          dateKeluar.text = formattedDate;
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Tanggal Pengeluaran Tidak Boleh Kosong!";
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
                        child: Text('Print Surat Pernyataan',
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
                          inputKotaKeluar(),
                          const SizedBox(height: 10),
                          inputTglKeluar(),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: enableOne,
                                  onChanged: (bool value) {
                                    setState(() {
                                      enableOne = !enableOne;
                                    });
                                  },
                                ),
                                const SizedBox(height: 5),
                                const Text('SP 1'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: enableTwo,
                                  onChanged: (bool value) {
                                    setState(() {
                                      enableTwo = !enableTwo;
                                    });
                                  },
                                ),
                                const SizedBox(height: 5),
                                const Text('SP 2'),
                              ],
                            ),
                          ),
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
