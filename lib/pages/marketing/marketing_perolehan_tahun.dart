import 'package:flutter_web_course/constants/dummy_jadwal_jamaah.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/chart_laporan_tahunan%20copy.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/chart_laporan_tahunan.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/table_laporan_tahunan.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/modal_pemberangkatan_tourlead.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/table_tourleader.dart';

class MarketingPerolehanTahunan extends StatefulWidget {
  const MarketingPerolehanTahunan({Key key}) : super(key: key);

  @override
  State<MarketingPerolehanTahunan> createState() =>
      _MarketingPerolehanTahunanState();
}

class _MarketingPerolehanTahunanState extends State<MarketingPerolehanTahunan> {
  List<Map<String, dynamic>> listPerolehanTahun = [];

  void getPerolehan() async {
    var response =
        await http.get(Uri.parse("$urlAddress/data/dashboard/laporan-tahunan"));
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    setState(() {
      listPerolehanTahun = data;
    });
  }

  @override
  void initState() {
    getPerolehan();
    super.initState();
  }

  // Widget cmdPrint() {
  //   return ElevatedButton.icon(
  //     onPressed: () {},
  //     icon: const Icon(Icons.print_outlined),
  //     label: const Text(
  //       'Akumulasi TL',
  //       style: TextStyle(fontFamily: 'Gilroy'),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: myBlue,
  //       minimumSize: const Size(100, 40),
  //       shadowColor: Colors.grey,
  //       elevation: 5,
  //     ),
  //   );
  // }

  // Widget cmdTlBerangkat() {
  //   return ElevatedButton.icon(
  //     onPressed: () {
  //       showDialog(
  //           context: context,
  //           builder: (context) => const ModalPemberangkatanTourlead());
  //     },
  //     icon: const Icon(Icons.list_alt_outlined),
  //     label: const Text(
  //       'Pemberangkatan TL',
  //       style: TextStyle(fontFamily: 'Gilroy'),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: myBlue,
  //       minimumSize: const Size(100, 40),
  //       shadowColor: Colors.grey,
  //       elevation: 5,
  //     ),
  //   );
  // }

  // Widget spacePemisah() {
  //   return const SizedBox(
  //     height: 10,
  //     width: 10,
  //   );
  // }

  // Widget menuButton() => Container(
  //       height: 50,
  //       alignment: Alignment.centerRight,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               cmdPrint(),
  //               //---------------------------------
  //               spacePemisah(),
  //               //---------------------------------
  //               cmdTlBerangkat(),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text:
                          'Marketing - Laporan - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(height: 10),
          SizedBox(
            height: 533,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(5),
                  child: const ChartLaporanTahunan(),
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: lightGrey.withOpacity(0.2),
                            blurRadius: 12)
                      ],
                    ),
                    child:
                        TableLaporanTahunan(listPerolehan: listPerolehanTahun),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
