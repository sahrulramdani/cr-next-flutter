// ignore_for_file: avoid_print, deprecated_member_use, unnecessary_new

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:universal_html/html.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DownloadGambarPaket extends StatefulWidget {
  final String keberangkatan;
  final String foto;
  const DownloadGambarPaket({
    Key key,
    @required this.keberangkatan,
    @required this.foto,
  }) : super(key: key);

  @override
  State<DownloadGambarPaket> createState() => _DownloadGambarPaketState();
}

class _DownloadGambarPaketState extends State<DownloadGambarPaket> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final urlImage = widget.foto != 'NONE'
            ? '$urlAddress/uploads/paket/${widget.foto}'
            : 'https://media-cdn.tripadvisor.com/media/photo-s/22/a5/00/e7/exterior.jpg';

        downloadFoto(urlImage);
      },
      icon: const Icon(Icons.download_for_offline_outlined),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[700],
        minimumSize: ResponsiveWidget.isSmallScreen(context)
            ? const Size(60, 40)
            : const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
      label: fncLabelButtonStyle('Download Foto', context),
    );
  }

  downloadFoto(urlImage) async {
    // AnchorElement anchorElement = new AnchorElement(href: url);
    // anchorElement.download = "paket-keberangkatan-${widget.keberangkatan}.png";
    // anchorElement.click();
    final url = Uri.parse(urlImage);
    final response = await http.get(url);
    final imageByte = response.bodyBytes;
    Uint8List bytes = imageByte;

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "produk-${widget.keberangkatan}.png")
      ..click();
  }
}
