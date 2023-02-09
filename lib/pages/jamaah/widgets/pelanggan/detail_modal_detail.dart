// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/info_estimasi_bayar.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/info_paket.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/info_pelanggan.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/info_riwayat_bayar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:flutter_web_course/comp/modal_delete_fail.dart';
// import 'package:flutter_web_course/comp/modal_delete_success.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_web_course/models/http_controller.dart';

class DetailModalDetail extends StatefulWidget {
  String idPelanggan;
  String namaPelanggan;
  DetailModalDetail(
      {Key key, @required this.idPelanggan, @required this.namaPelanggan})
      : super(key: key);

  @override
  State<DetailModalDetail> createState() => _DetailModalDetailState();
}

class _DetailModalDetailState extends State<DetailModalDetail> {
  bool enablePaket = true;
  bool enableDetail = false;
  bool enablePembayaran = false;
  bool enableRiwayat = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: screenWidth * 0.7,
          height: 700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                      child: Text('Detail ${widget.namaPelanggan}',
                          style: TextStyle(
                              color: myGrey, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: GNav(
                  backgroundColor: Colors.white,
                  color: Colors.grey,
                  activeColor: const Color.fromARGB(255, 14, 116, 199),
                  tabBackgroundColor: const Color.fromARGB(255, 227, 238, 255),
                  gap: 6,
                  padding: const EdgeInsets.all(16),
                  tabs: [
                    GButton(
                      icon: Icons.playlist_add_check_circle_outlined,
                      text: 'Paket',
                      onPressed: () {
                        setState(() {
                          enablePaket = true;
                          enableDetail = false;
                          enablePembayaran = false;
                          enableRiwayat = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.details,
                      text: 'Detail Pelanggan',
                      onPressed: () {
                        setState(() {
                          enablePaket = false;
                          enableDetail = true;
                          enablePembayaran = false;
                          enableRiwayat = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.payments_outlined,
                      text: 'Estimasi Pembayaran',
                      onPressed: () {
                        setState(() {
                          enablePaket = false;
                          enableDetail = false;
                          enablePembayaran = true;
                          enableRiwayat = false;
                        });
                      },
                    ),
                    GButton(
                      icon: Icons.party_mode_outlined,
                      text: 'Riwayat Pembayaran',
                      onPressed: () {
                        setState(() {
                          enablePaket = false;
                          enableDetail = false;
                          enablePembayaran = false;
                          enableRiwayat = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: screenWidth,
                  child: Column(children: [
                    Visibility(
                      visible: enablePaket,
                      child: SizedBox(
                          child: InfoPaket(idPelanggan: widget.idPelanggan)),
                    ),
                    Visibility(
                      visible: enableDetail,
                      child: SizedBox(
                          child:
                              InfoPelanggan(idPelanggan: widget.idPelanggan)),
                    ),
                    Visibility(
                      visible: enablePembayaran,
                      child: SizedBox(
                          child: InfoEstimasiBayar(
                              idPelanggan: widget.idPelanggan)),
                    ),
                    Visibility(
                      visible: enableRiwayat,
                      child: SizedBox(
                          child: InfoRiwayatBayar(
                        idPelanggan: widget.idPelanggan,
                      )),
                    ),
                  ]),
                ),
              )),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
        )
      ]),
    );
  }
}
