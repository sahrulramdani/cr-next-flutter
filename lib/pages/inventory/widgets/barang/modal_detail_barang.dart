// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/controllers.dart';
import 'package:flutter_web_course/pages/inventory/widgets/barang/detail_table_riwayat.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';
import "package:http/http.dart" as http;

class ModalDetailBarang extends StatefulWidget {
  final String idBarang;
  const ModalDetailBarang({Key key, @required this.idBarang}) : super(key: key);

  @override
  State<ModalDetailBarang> createState() => _ModalDetailBarangState();
}

class _ModalDetailBarangState extends State<ModalDetailBarang> {
  String tglAwal;
  TextEditingController dateAwal = TextEditingController();
  String tglAkhir;
  TextEditingController dateAkhir = TextEditingController();

  Widget spacePemisah() {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }

  Widget cmdPrint() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.print),
      label: const Text('Print'),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdQrCode() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.qr_code),
      label: const Text('QR Code'),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdTampil() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.file_download_done),
      label: const Text('Tampil'),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        minimumSize: const Size(100, 40),
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget inputTglAwal() {
    return TextField(
      controller: dateAwal,
      decoration: const InputDecoration(
        labelText: 'Tanggal Awal',
      ),
      onChanged: (String value) {
        tglAwal = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            dateAwal.text = formattedDate;
          });
        }
      },
    );
  }

  Widget inputTglAkhir() {
    return TextField(
      controller: dateAkhir,
      decoration: const InputDecoration(
        labelText: 'Tanggal Akhir',
      ),
      onChanged: (String value) {
        tglAkhir = value;
      },
      onTap: () async {
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            dateAkhir.text = formattedDate;
          });
        }
      },
    );
  }

  Widget menuButton() => SizedBox(
        height: 50,
        child: Row(
          children: [
            SizedBox(width: 150, child: inputTglAwal()),
            spacePemisah(),
            SizedBox(width: 150, child: inputTglAkhir()),
            spacePemisah(),
            cmdTampil(),
            spacePemisah(),
            cmdPrint(),
            spacePemisah(),
            cmdQrCode(),
          ],
        ),
      );

  fncSaveData() {
    showDialog(
        context: context, builder: (context) => const ModalSaveSuccess());

    menuController.changeActiveitemTo('Barang');
    navigationController.navigateTo('/inventory/barang');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.81,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Daftar Riwayat ',
                          // 'Daftar Riwayat ${listBarang[int.parse(widget.idBarang)]['nama']}',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                menuButton(),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: const [
                            SizedBox(height: 30),
                            DetailTableRiwayat(),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          fncSaveData();
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Simpan Data',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myBlue,
                          shadowColor: Colors.grey,
                          elevation: 5,
                        ),
                      ),
                      const SizedBox(width: 10),
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
          ),
        )
      ]),
    );
  }
}
