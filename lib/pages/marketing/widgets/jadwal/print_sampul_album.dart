// ignore_for_file: unused_local_variable, avoid_web_libraries_in_flutter, use_build_context_synchronously, division_optimization
import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_data_fail.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter_web_course/constants/style.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

class PrintSampulAlbum extends StatefulWidget {
  // final List<Map<String, dynamic>> listPelangganJadwal;
  String tglBgkt;
  String jenisPaket;
  // String tglPlng;

  PrintSampulAlbum({
    Key key,
    // @required this.listPelangganJadwal,
    @required this.tglBgkt,
    @required this.jenisPaket,
    // @required this.tglPlng,
  }) : super(key: key);

  @override
  State<PrintSampulAlbum> createState() => _PrintSampulAlbumState();
}

class _PrintSampulAlbumState extends State<PrintSampulAlbum> {
  // List<Map<String, dynamic>> listPelanggan = [];
  // List<pw.MemoryImage> gambarPelanggan = [];

  // Future<void> _loadImages() async {
  //   for (int i = 0; i < listPelanggan.length; i++) {
  //     if (listPelanggan[i]['FOTO_JMAH'] != '') {
  //       final response = await http.get(Uri.parse(
  //           '$urlAddress/uploads/foto/${listPelanggan[i]['FOTO_JMAH']}'));
  //       final bytes = response.bodyBytes;
  //       final image = pw.MemoryImage(bytes);
  //       setState(() {
  //         gambarPelanggan.add(image);
  //       });
  //     } else {
  //       final response = await http.get(Uri.parse(
  //           'https://www.shutterstock.com/image-vector/profile-blank-icon-empty-photo-260nw-535853269.jpg'));
  //       final bytes = response.bodyBytes;
  //       final image = pw.MemoryImage(bytes);
  //       setState(() {
  //         gambarPelanggan.add(image);
  //       });
  //     }
  //   }
  // }

  Future<void> _createPDF() async {
    const pageFormatCustom =
        PdfPageFormat(20.5 * PdfPageFormat.cm, 24.5 * PdfPageFormat.cm);

    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    final font2 = await rootBundle.load("assets/fonts/ScriptMTBold.ttf");
    final ttf = pw.Font.ttf(font);
    final ttf2 = pw.Font.ttf(font2);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pageFormatCustom,
        orientation: pw.PageOrientation.landscape,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Wrap(
              children: <pw.Widget>[
                pw.Container(
                    width: pageFormatCustom.width,
                    child: pw.Container(
                        child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Container(
                            width: pageFormatCustom.height * 0.5,
                            height: pageFormatCustom.width,
                            padding: const pw.EdgeInsets.all(50),
                            child: pw.Column(children: [
                              pw.Row(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                              DateFormat(fncGetTanggal(
                                                      widget.tglBgkt))
                                                  .format(DateTime.now()),
                                              style: pw.TextStyle(
                                                  fontSize: 25,
                                                  font: ttf2,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.Text(widget.jenisPaket,
                                              style: pw.TextStyle(
                                                  fontSize: 20,
                                                  font: ttf2,
                                                  fontWeight:
                                                      pw.FontWeight.bold))
                                        ]),
                                  ]),
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
      ..setAttribute("download", "sampul_album_${widget.tglBgkt}.pdf")
      ..click();
  }

  // fncGetCek() {
  //   listPelanggan = [];

  //   for (var i = 0; i < widget.listPelangganJadwal.length; i++) {
  //     if (widget.listPelangganJadwal[i]['CEK'] == true) {
  //       listPelanggan.add(widget.listPelangganJadwal[i]);
  //     }
  //   }

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        // await fncGetCek();

        // await _loadImages();

        // if (listPelanggan.isNotEmpty) {
        _createPDF();
        // } else {
        //   showDialog(
        //       context: context, builder: (context) => const ModalDataFail());
        // }
      },
      icon: const Icon(Icons.photo_camera_front_outlined),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Sampul Album', context),
    );
  }
}
