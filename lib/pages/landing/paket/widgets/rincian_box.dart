import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_web_course/controllers/func_all.dart';

class RincianBoxWidget extends StatefulWidget {
  const RincianBoxWidget({
    Key key,
  }) : super(key: key);

  @override
  State<RincianBoxWidget> createState() => _AdversitingBoxWidgetState();
}

class _AdversitingBoxWidgetState extends State<RincianBoxWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return Container(
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
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          screenWidth <= mediumScreenSize
              ? Column(
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Catatan :",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text("Harga dapat berubah sewaktu waktu",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text("Harga belum termasuk :",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text("- Handling Rp.1,600,000",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 5),
                          Text(
                              "- Paspor Rp.1,000,000 (Apabila kolektif kantor)",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 5),
                          Text("- Keperluan Pribadi",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Fasilitas Paket :",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 25),
                                Text("- Tiket Pesawat",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Hotel", style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Visa", style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- LA", style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Makan dan Minum",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Fasilitas Handling :",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 25),
                                Text("- Perlengkapan",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Handling Cengkareng",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Transport Lokal",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Manasik",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Asuransi",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Catatan :",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text("Harga dapat berubah sewaktu waktu",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text("Harga belum termasuk :",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text("- Handling Rp.1,600,000",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 5),
                          Text(
                              "- Paspor Rp.1,000,000 (Apabila kolektif kantor)",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 5),
                          Text("- Keperluan Pribadi",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    )),
                    Expanded(
                        child: SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Fasilitas Paket :",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 25),
                                Text("- Tiket Pesawat",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Hotel", style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Visa", style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- LA", style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Makan dan Minum",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Fasilitas Handling :",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 25),
                                Text("- Perlengkapan",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Handling Cengkareng",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Transport Lokal",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Manasik",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text("- Asuransi",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                )
        ],
      ),
    );
  }
}
