// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/finance/widgets/pembayaran/chart_pembayaran.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PembayaranInfoLarge extends StatefulWidget {
  const PembayaranInfoLarge({Key key}) : super(key: key);

  @override
  State<PembayaranInfoLarge> createState() => _PembayaranInfoLargeState();
}

class _PembayaranInfoLargeState extends State<PembayaranInfoLarge> {
  List<Map<String, dynamic>> listChartPembayaran = [];
  List<Map<String, dynamic>> totalTagihan = [];

  getListChart() async {
    var response = await http
        .get(Uri.parse("$urlAddress/finance/chart/total-bulanan"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      listChartPembayaran = dataStatus;
    });
  }

  getTotalTagihan() async {
    var response = await http.get(
        Uri.parse("$urlAddress/finance/info-data/total-tagihan"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> dataStatus =
        List.from(json.decode(response.body) as List);
    setState(() {
      totalTagihan = dataStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    getListChart();
    getTotalTagihan();
  }

  @override
  Widget build(BuildContext context) {
    var year = DateTime.now().year;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 300,
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.business_outlined,
                        color: myBlue,
                        size: 50.0,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kantor Pusat',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: myBlue),
                          ),
                          const SizedBox(height: 5),
                          const SizedBox(
                            width: 210,
                            child: Text(
                              'Jl. Bintara 8, No 18, Bintara, Bekasi Barat, Kota Bekasi',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontFamily: 'Gilroy', fontSize: 12),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Row(
                        children: [
                          const Text(
                            'Tagihan Tersisa',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            ':',
                            style:
                                TextStyle(fontFamily: 'Gilroy', fontSize: 17),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            totalTagihan.isNotEmpty
                                ? "Rp." +
                                    myFormat.format(
                                        totalTagihan[0]['TOTAL_TAGIHAN'])
                                : 'Rp.0',
                            style: const TextStyle(
                                fontFamily: 'Gilroy', fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        authAddx == '1'
                            ? {
                                menuController.changeActiveitemTo('Form Bayar'),
                                navigationController
                                    .navigateTo('/finance/form-bayar')
                              }
                            : showDialog(
                                context: context,
                                builder: (context) => const ModalInfo(
                                      deskripsi: 'Anda Tidak Memiliki Akses',
                                    ));
                      },
                      icon: const Icon(Icons.add_card_sharp),
                      label: const Text(
                        'Lakukan Pembayaran',
                        style: TextStyle(fontFamily: 'Gilroy'),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            authAddx == '1' ? myBlue : Colors.blue[200],
                        minimumSize: const Size(100, 40),
                        shadowColor: Colors.grey,
                        elevation: 5,
                      ),
                    )
                  ]),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
            child: Container(
                height: 220,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: "Total Pembayaran $year",
                      size: 20,
                      weight: FontWeight.bold,
                      color: myBlue,
                    ),
                    SizedBox(
                      width: 700,
                      height: 150,
                      child: ChartPembayaran.withSampleData(),
                    )
                  ],
                )))
      ],
    );
  }
}
