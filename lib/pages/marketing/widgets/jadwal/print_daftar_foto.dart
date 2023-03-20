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

class PrintDaftarFoto extends StatefulWidget {
  final List<Map<String, dynamic>> listPelangganJadwal;
  final String tglBgkt;

  const PrintDaftarFoto(
      {Key key, @required this.listPelangganJadwal, @required this.tglBgkt})
      : super(key: key);

  @override
  State<PrintDaftarFoto> createState() => _PrintDaftarFotoState();
}

class _PrintDaftarFotoState extends State<PrintDaftarFoto> {
  List<Map<String, dynamic>> listPelanggan = [];
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
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/open-sans.ttf");
    final ttf = pw.Font.ttf(font);

    int pages = (listPelanggan.length / 20).toInt() + 1;
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
                                  crossAxisCount: 5,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 7 / 4,
                                  children: [
                                for (var i = (arrData + ((a - 1) * 20));
                                    i < (a != pages ? (a * 20) : maxData);
                                    i++)
                                  pw.Container(
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColors.black),
                                      ),
                                      child: pw.Column(children: [
                                        pw.Container(
                                          height: 135,
                                          width: 90,
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
      ..setAttribute("download", "daftar_foto_${widget.tglBgkt}.pdf")
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
      icon: const Icon(Icons.image_aspect_ratio_outlined),
      style: fncButtonAuthStyle(authPrnt, context),
      label: fncLabelButtonStyle('Daftar Foto', context),
    );
  }
}
