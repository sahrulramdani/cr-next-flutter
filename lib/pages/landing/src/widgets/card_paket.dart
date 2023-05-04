import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardPaketLanding extends StatefulWidget {
  final String jenis;
  final String idPaket;
  final String judul;
  final String keterangan;
  final String keberangkatan;
  final int harga;
  final String mu;
  final int sisa;
  final String foto;

  const CardPaketLanding(
      {this.jenis,
      this.idPaket,
      this.judul,
      this.keterangan,
      this.keberangkatan,
      this.harga,
      this.mu,
      this.sisa,
      this.foto,
      key})
      : super(key: key);

  @override
  State<CardPaketLanding> createState() => _CardPaketLandingState();
}

class _CardPaketLandingState extends State<CardPaketLanding> {
  double widthCard = 270;
  double heightCard = 470;
  double heightPict = 270;
  double sizeJudul = 30;
  double sizeDescription = 11;
  double sizeHarga = 25;
  double sizeSeat = 12;
  double horizontalMargin = 20;
  double verticalMargin = 15;

  // void getSize() async {
  //   if (widget.jenis == 'XX') {
  //     widthCard = 270;
  //     heightCard = 470;
  //     heightPict = 270;
  //     sizeJudul = 30;
  //     sizeDescription = 11;
  //     sizeHarga = 25;
  //     sizeSeat = 12;
  //     horizontalMargin = 20;
  //     verticalMargin = 15;
  //   } else {
  //     widthCard = 180;
  //     heightCard = 350;
  //     heightPict = 180;
  //     sizeJudul = 20;
  //     sizeDescription = 9;
  //     sizeHarga = 14;
  //     sizeSeat = 10;
  //     horizontalMargin = 8;
  //     verticalMargin = 8;
  //   }
  // }

  // @override
  // void initState() {
  //   getSize();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

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
                    : const AssetImage('assets/images/NO_IMAGE.jpg')),
          ),
          child: const SizedBox(),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
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
                  menuController.changeActiveitemTo("");
                  Get.offAllNamed('/paket/${widget.idPaket}');
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
              )
            ],
          ),
        ))
      ]),
    );
  }
}
