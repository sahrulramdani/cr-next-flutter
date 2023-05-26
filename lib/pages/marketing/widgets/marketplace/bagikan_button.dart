// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class BagikanButtonWidget extends StatefulWidget {
  final String judul;
  final String desc;
  final String urlAgen;
  final String keberangkatan;
  final String harga;
  final int sisa;
  final String maskapai;
  // final String foto;
  const BagikanButtonWidget({
    Key key,
    @required this.judul,
    @required this.desc,
    @required this.urlAgen,
    @required this.keberangkatan,
    @required this.harga,
    @required this.sisa,
    @required this.maskapai,
    // @required this.foto,
  }) : super(key: key);

  @override
  State<BagikanButtonWidget> createState() => _BagikanButtonWidgetState();
}

class _BagikanButtonWidgetState extends State<BagikanButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        var tglNow =
            fncGetTanggal(DateFormat('dd-MM-yyyy').format(DateTime.now()));
        var pesan =
            "${widget.judul} \n${widget.desc} \n\nKeberangkatan Pada Tanggal : ${widget.keberangkatan} \nDengan Menggunakan Maskapai : ${widget.maskapai} \n\nDengan Harga Mulai Dari ${widget.harga} \n\nSeat Tersisa : ${widget.sisa} \nUpdate pertanggal $tglNow \nAyo Segera Daftarkan Dirimu Menjadi Bagian Dari Jamaah Cahaya Raudhah!!! \n\n ${widget.urlAgen}";
        var encoded = Uri.encodeFull(pesan);

        var whatsappShare = "https://api.whatsapp.com/send?text=$encoded";

        await launch(whatsappShare);

        // launch(urlString);
        // final urlImage = widget.foto != 'NONE'
        //     ? '$urlAddress/uploads/paket/${widget.foto}'
        //     : 'https://media-cdn.tripadvisor.com/media/photo-s/22/a5/00/e7/exterior.jpg';
        // final url = Uri.parse(urlImage);
        // final response = await http.get(url);
        // final bytes = response.bodyBytes;

        // var file = [
        //   html.File([bytes], "imagename.jpg", {"type": "image/jpeg"})
        // ];
        // var data = {
        //   "title": widget.judul,
        //   "text":
        //       "${widget.desc} - Keberangkatan Tanggal : ${widget.keberangkatan} - Harga : ${widget.harga}",
        //   "url": widget.urlAgen,
        //   "files": file
        // };

        // share(data);

        // print(data);

        // MOBILE
        // final urlImage = widget.foto != 'NONE'
        //     ? '$urlAddress/uploads/paket/${widget.foto}'
        //     : 'https://media-cdn.tripadvisor.com/media/photo-s/22/a5/00/e7/exterior.jpg';
        // const urlImage =
        //     'https://media-cdn.tripadvisor.com/media/photo-s/22/a5/00/e7/exterior.jpg';
        // final url = Uri.parse(urlImage);
        // final response = await http.get(url);
        // final bytes = response.bodyBytes;

        // final temp = await getTemporaryDirectory();
        // final path = '${temp.path}/image.jpg';
        // File(path).writeAsBytesSync(bytes);

        // // print(path);
        // await Share.shareFiles([path], text: 'Percobaan Share Info');
        // await Share.share('check out my website https://example.com');

        // MOBILE

        // FlutterClipboard.copy(widget.urlAgen);
        // Get.snackbar(
        //   "Link Berhasil Disalin",
        //   "Silahkan Berikan Link Ke Jamaah Kamu",
        //   icon: const Icon(Icons.person, color: Colors.white),
        //   snackPosition: SnackPosition.TOP,
        // );
      },
      icon: const Icon(Icons.whatsapp_outlined),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[600],
        minimumSize: ResponsiveWidget.isSmallScreen(context)
            ? const Size(60, 40)
            : const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
      label: fncLabelButtonStyle('Salin & Bagikan', context),
    );
  }

  void share(Map data) async {
    try {
      // print(data);
      await html.window.navigator.share(data);
    } catch (e) {
      print(e);
    }
  }
}
