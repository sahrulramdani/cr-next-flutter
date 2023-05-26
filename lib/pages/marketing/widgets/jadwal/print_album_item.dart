// ignore_for_file: unused_local_variable, missing_return, use_build_context_synchronously, division_optimization

import 'dart:convert';
import "package:universal_html/html.dart";
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

class ModalAlbumItem extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  String tglBgkt;
  String tglPlng;

  ModalAlbumItem(
      {Key key,
      @required this.listPelangganJadwal,
      @required this.tglBgkt,
      @required this.tglPlng})
      : super(key: key);
  @override
  State<ModalAlbumItem> createState() => _ModalAlbumItemState();
}

class _ModalAlbumItemState extends State<ModalAlbumItem> {
  List<Map<String, dynamic>> listPelanggan = [];
  TextEditingController dateKeluar = TextEditingController();
  String kotaKeluar;
  String noUrut = '1';
  bool enableOne = false;
  bool enableTwo = false;
  List<pw.MemoryImage> gambarPelanggan = [];

  Future<void> _loadImages() async {
    for (int i = 0; i < listPelanggan.length; i++) {
      if (listPelanggan[i]['FOTO_JMAH'] != '') {
        final response = await http.get(Uri.parse(
            '$urlAddress/uploads/foto/${listPelanggan[i]['FOTO_JMAH']}'));
        final bytes = response.bodyBytes;
        final image = pw.MemoryImage(bytes);
        setState(() {
          gambarPelanggan.add(image);
        });
      } else {
        final response = await http.get(Uri.parse(
            'https://www.shutterstock.com/image-vector/profile-blank-icon-empty-photo-260nw-535853269.jpg'));
        final bytes = response.bodyBytes;
        final image = pw.MemoryImage(bytes);
        setState(() {
          gambarPelanggan.add(image);
        });
      }
    }
  }

  Future<void> _createPDF() async {
    const pageFormatCustom =
        PdfPageFormat(20.5 * PdfPageFormat.cm, 24.5 * PdfPageFormat.cm);

    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    final font2 = await rootBundle.load("assets/fonts/ScriptMTBold.ttf");
    final ttf = pw.Font.ttf(font);
    final ttf2 = pw.Font.ttf(font2);

    int pages = (listPelanggan.length / 8).toInt() + 1;
    int urut = int.parse(noUrut);
    // Maksimal index data
    int maxData = listPelanggan.length;
    int maxSide = (listPelanggan.length / 4).toInt() + 1;
    int j = 0;

    if (widget.tglPlng == 'null') {
      widget.tglPlng = '00-12-0000';
    }

    int arrB = 0;
    int arrData = 0;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormatCustom,
        orientation: pw.PageOrientation.landscape,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (pw.Context context) {
          return <pw.Widget>[
            for (var a = 1; a <= pages; a++)
              pw.Wrap(
                children: <pw.Widget>[
                  pw.Container(
                      width: pageFormatCustom.width,
                      child: pw.Container(
                          child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          for (var b = arrB;
                              b < (b != maxSide ? (a * 2) : maxSide);
                              b++, arrB++)
                            pw.Container(
                                width: pageFormatCustom.height * 0.5,
                                height: pageFormatCustom.width,
                                padding: const pw.EdgeInsets.all(25),
                                child: pw.Column(children: [
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.end,
                                      children: [
                                        pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.center,
                                            children: [
                                              pw.Text(
                                                  DateFormat("yyyy")
                                                      .format(DateTime.now()),
                                                  style: pw.TextStyle(
                                                      fontSize: 25,
                                                      font: ttf2,
                                                      fontWeight:
                                                          pw.FontWeight.bold)),
                                              pw.Text(
                                                  fncInfoPeriode(widget.tglBgkt,
                                                      widget.tglPlng),
                                                  style: pw.TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          pw.FontWeight.bold))
                                            ]),
                                      ]),
                                  for (var c = arrData;
                                      c <
                                          (b != (maxSide - 1)
                                              ? ((b + 1) * 4)
                                              : maxData);
                                      c++, arrData++)
                                    pw.Container(
                                        padding: const pw.EdgeInsets.only(
                                            right: 10, top: 10),
                                        width: pageFormatCustom.height * 0.4,
                                        child: pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text((urut++).toString(),
                                                style: const pw.TextStyle(
                                                    fontSize: 7)),
                                            pw.SizedBox(width: 5),
                                            pw.Container(
                                              height: 90,
                                              width: 60,
                                              decoration: pw.BoxDecoration(
                                                border: pw.Border.all(
                                                    color: PdfColors.black),
                                                borderRadius:
                                                    const pw.BorderRadius.only(
                                                  topRight:
                                                      pw.Radius.circular(10),
                                                  bottomLeft:
                                                      pw.Radius.circular(10),
                                                ),
                                                image: pw.DecorationImage(
                                                  image: gambarPelanggan[c],
                                                  fit: pw.BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            pw.SizedBox(width: 10),
                                            pw.SizedBox(
                                                width: 200,
                                                child: pw.Table.fromTextArray(
                                                    headerHeight: 0,
                                                    cellStyle:
                                                        const pw.TextStyle(
                                                            fontSize: 7),
                                                    border: pw.TableBorder.all(
                                                        color: PdfColors.white),
                                                    headers: [],
                                                    columnWidths: {
                                                      0: const pw
                                                          .FlexColumnWidth(3),
                                                      1: const pw
                                                          .FlexColumnWidth(0.5),
                                                      2: const pw
                                                          .FlexColumnWidth(5),
                                                    },
                                                    cellPadding: const pw
                                                            .EdgeInsets.symmetric(
                                                        vertical: 2,
                                                        horizontal: 5),
                                                    data: <List>[
                                                      [
                                                        "NAMA",
                                                        ":",
                                                        listPelanggan[c]
                                                            ['NAMA_LGKP'],
                                                      ],
                                                      [
                                                        "NO. PASPOR",
                                                        ":",
                                                        listPelanggan[c]
                                                                ['NOXX_PSPR']
                                                            .toString()
                                                      ],
                                                      [
                                                        "TMPT TGL LHR",
                                                        ":",
                                                        "${listPelanggan[c]['TMPT_LHIR']}, ${fncGetTanggal(DateFormat("dd-MM-yyyy").format(DateTime.parse(listPelanggan[c]['TGLX_LHIR'])))}"
                                                      ],
                                                      [
                                                        "TELP	",
                                                        ":",
                                                        listPelanggan[c]
                                                                ['NOXX_TELP']
                                                            .toString(),
                                                      ],
                                                      [
                                                        "ALAMAT	",
                                                        ":",
                                                        listPelanggan[c]
                                                                ['ALAMAT']
                                                            .toString(),
                                                      ],
                                                    ])),
                                          ],
                                        ))
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
      ..setAttribute("download", "album_items_${widget.tglBgkt}.pdf")
      ..click();

    Navigator.pop(context);
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

  Widget inputNoUrut() {
    return TextFormField(
      initialValue: noUrut ?? "1",
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          labelText: 'Masukan No Urut Lanjutan',
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white),
      onChanged: (value) {
        noUrut = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "No Urut Tidak Boleh Kosong";
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
            width: 350,
            height: 150,
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
                        child: Text('Print Album Item',
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
                          inputNoUrut(),
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
                          await fncGetCek();

                          await _loadImages();

                          if (listPelanggan.isNotEmpty) {
                            _createPDF();
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => const ModalDataFail());
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
