import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardPaketLanding extends StatelessWidget {
  final String id;
  final String judul;
  final String keterangan;
  final int harga;
  final String mu;
  final int sisa;

  const CardPaketLanding(
      {this.id,
      this.judul,
      this.keterangan,
      this.harga,
      this.mu,
      this.sisa,
      key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return Container(
      margin: const EdgeInsets.only(right: 40),
      width: 270,
      height: 470,
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
          width: 270,
          height: 270,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/default-poster.png')),
          ),
          child: const SizedBox(),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                judul,
                style: const TextStyle(
                    color: Color.fromARGB(255, 232, 174, 0),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(keterangan,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("$mu.${myFormat.format(harga)}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800])),
              const SizedBox(height: 5),
              Text("Sisa seat tersedia : $sisa",
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () async {
                  Get.snackbar("Information", "Menu Masih Dalam Proses",
                      snackPosition: SnackPosition.TOP,
                      animationDuration: const Duration(milliseconds: 200));
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
      //  Row(
      //   children: [
      //     Expanded(
      //       child: Container(
      //         padding: const EdgeInsets.all(10),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               judul,
      //               maxLines: 2,
      //               style: const TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontFamily: 'Gilroy',
      //                   fontSize: 15,
      //                   color: Colors.white),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Container(
      //       width: 100,
      //       padding: const EdgeInsets.all(10),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           FittedBox(
      //             child: Text(
      //               keterangan,
      //               maxLines: 2,
      //               style: const TextStyle(fontSize: 30, color: Colors.white),
      //             ),
      //           )
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
