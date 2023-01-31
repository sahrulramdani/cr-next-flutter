import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/pelanggan/table_pelanggan.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/dummy_pelanggan.dart';
import 'package:flutter_web_course/comp/card_info.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

class JamaahPelangganPage extends StatefulWidget {
  const JamaahPelangganPage({Key key}) : super(key: key);

  @override
  State<JamaahPelangganPage> createState() => _JamaahPelangganPageState();
}

class _JamaahPelangganPageState extends State<JamaahPelangganPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> listPelanggan = dummyPelangganTable;

    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: 'Jamaah - ${menuController.activeItem.value}',
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            width: screenWidth,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: listCardPelanggan.map((data) {
                return MyCardInfo(title: data['title'], total: data['total']);
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: screenWidth,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Daftar Kepelangganan',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: myBlue),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 230,
                            child: DropdownSearch(
                              mode: Mode.MENU,
                              items: const [
                                "Filter",
                                "Evaluasi Pembayaran",
                                "Jadwal Pasporan",
                                "Belum Handling",
                                "Belum Persyaratan",
                                "Belum Pasporan",
                              ],
                              onChanged: print,
                              selectedItem: "Filter",
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 40,
                            width: 200,
                            child: DropdownSearch(
                              mode: Mode.MENU,
                              items: const [
                                "Semua",
                                "Pusat",
                                "Turangga",
                                "Tasikmalaya",
                                "KPRK Garut",
                                "KPRK Tasikmalaya",
                                "KPRK Karawang",
                                "KPRK Purwakarta",
                                "KPRK Cirebon",
                              ],
                              onChanged: print,
                              selectedItem: "Semua",
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 250,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontFamily: 'Gilroy', fontSize: 14),
                              decoration: const InputDecoration(
                                  hintText: 'Cari Berdasarkan Nama'),
                              onChanged: (value) {
                                if (value == '') {
                                  setState(() {
                                    listPelanggan = dummyPelangganTable;
                                  });
                                } else {
                                  setState(() {
                                    listPelanggan = dummyPelangganTable
                                        .where(((element) =>
                                            element['nama_lengkap']
                                                .toString()
                                                .toUpperCase()
                                                .contains(value.toUpperCase())))
                                        .toList();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TablePelanggan(dataPelanggan: listPelanggan),
              ],
            ),
          )
        ],
      ),
    );
  }
}
