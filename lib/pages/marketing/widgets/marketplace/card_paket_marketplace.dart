// ignore_for_file: unused_local_variable

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/marketing/widgets/marketplace/bagikan_button.dart';
import 'package:flutter_web_course/pages/marketing/widgets/marketplace/download_gambar_paket.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:js/js.dart' as js;

class CardPaketMarketplace extends StatefulWidget {
  final String jenis;
  final String idPaket;
  final String judul;
  final String keterangan;
  final String keberangkatan;
  final int harga;
  final String mu;
  final int sisa;
  final String foto;
  final String keberangkatanDi;
  final String maskapai;

  const CardPaketMarketplace(
      {this.jenis,
      this.idPaket,
      this.judul,
      this.keterangan,
      this.keberangkatan,
      this.harga,
      this.mu,
      this.sisa,
      this.foto,
      this.keberangkatanDi,
      this.maskapai,
      key})
      : super(key: key);

  @override
  State<CardPaketMarketplace> createState() => _CardPaketMarketplaceState();
}

class _CardPaketMarketplaceState extends State<CardPaketMarketplace> {
  double widthCard = 240;
  double heightCard = 630;
  double heightPict = 240;
  double sizeJudul = 25;
  double sizeDescription = 11;
  double sizeHarga = 24;
  double sizeSeat = 12;
  double horizontalMargin = 20;
  double verticalMargin = 15;

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    String url = Uri.base.origin;

    String urlAgen = "$url/pendaftaran/$kodeAgen/${widget.idPaket}";

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      width: widthCard,
      height: heightCard,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: [
        Container(
          width: widthCard,
          height: heightPict,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: widget.foto != ""
                    ? NetworkImage('$urlAddress/uploads/paket/${widget.foto}')
                    : const AssetImage('assets/images/none-produk.png')),
          ),
          child: const SizedBox(),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.judul,
                style: TextStyle(
                    color: const Color.fromARGB(255, 232, 174, 0),
                    fontSize: sizeJudul,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(widget.keterangan,
                  style: TextStyle(
                      fontSize: sizeDescription, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("Keberangkatan Tanggal ${widget.keberangkatan}",
                  style: TextStyle(
                      fontSize: sizeDescription, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("Titik Keberangkatan : ${widget.keberangkatanDi ?? 'CGK'}",
                  style: TextStyle(
                      fontSize: sizeDescription, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("${widget.mu}.${myFormat.format(widget.harga)}",
                  style: TextStyle(
                      fontSize: sizeHarga,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800])),
              const SizedBox(height: 5),
              Text("Sisa seat tersedia : ${widget.sisa}",
                  style: TextStyle(fontSize: sizeSeat)),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () async {
                  setState(() {
                    produkKode = widget.idPaket;
                  });

                  menuController.changeActiveitemTo('Detail Paket');
                  navigationController.navigateTo('/mrkt/detail-marketplace');
                },
                icon: const Icon(Icons.info),
                style: ElevatedButton.styleFrom(
                  backgroundColor: myBlue,
                  minimumSize: ResponsiveWidget.isSmallScreen(context)
                      ? const Size(60, 40)
                      : const Size(100, 40),
                  shadowColor: Colors.grey,
                  elevation: 5,
                ),
                label: fncLabelButtonStyle('Lihat Detail', context),
              ),
              const SizedBox(height: 10),
              DownloadGambarPaket(
                keberangkatan:
                    fncGetTanggal(widget.keberangkatan ?? '01-01-1111'),
                foto: widget.foto == "" ? 'NONE' : widget.foto,
              ),
              const SizedBox(height: 10),
              BagikanButtonWidget(
                judul: widget.judul,
                desc: widget.keterangan,
                urlAgen: urlAgen,
                keberangkatan:
                    fncGetTanggal(widget.keberangkatan ?? '01-01-1111'),
                harga: "${widget.mu}.${myFormat.format(widget.harga)}",
                sisa: widget.sisa ?? 0,
                maskapai: widget.maskapai ?? '-',
              ),
            ],
          ),
        ))
      ]),
    );
  }
}
