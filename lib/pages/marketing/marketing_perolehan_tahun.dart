import 'package:flutter_web_course/comp/header_title_menu.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/chart_laporan_tahunan.dart';
import 'package:flutter_web_course/pages/marketing/widgets/laporan-tahunan/table_laporan_tahunan.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';

class MarketingPerolehanTahunan extends StatefulWidget {
  const MarketingPerolehanTahunan({Key key}) : super(key: key);

  @override
  State<MarketingPerolehanTahunan> createState() =>
      _MarketingPerolehanTahunanState();
}

class _MarketingPerolehanTahunanState extends State<MarketingPerolehanTahunan> {
  List<Map<String, dynamic>> listPerolehanTahun = [];

  void getPerolehan() async {
    var response = await http
        .get(Uri.parse("$urlAddress/data/dashboard/laporan-tahunan"), headers: {
      'pte-token': kodeToken,
    });
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() => HeaderTitleMenu(menu: menuController.activeItem.value)),
        const SizedBox(height: 10),
        ResponsiveWidget.isSmallScreen(context)
            ? Expanded(
                child: SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 390,
                          padding: const EdgeInsets.all(5),
                          child: const ChartLaporanTahunan(),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 390,
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
                            child: Expanded(
                              child: SizedBox(
                                child: TableLaporanTahunan(
                                    listPerolehan: listPerolehanTahun),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Expanded(
                child: Row(
                children: [
                  const Expanded(child: ChartLaporanTahunan()),
                  const SizedBox(width: 10),
                  Expanded(
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
                    child: TableLaporanTahunan(
                      listPerolehan: listPerolehanTahun,
                    ),
                  )),
                ],
              )),
      ],
    );
  }
}
