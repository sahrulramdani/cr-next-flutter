// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
// import 'package:flutter_web_course/models/http_controller.dart';
import 'package:intl/intl.dart';

class DetailModalKonfirmPaspor extends StatefulWidget {
  const DetailModalKonfirmPaspor({
    Key key,
  }) : super(key: key);

  @override
  State<DetailModalKonfirmPaspor> createState() =>
      _DetailModalKonfirmPasporState();
}

class _DetailModalKonfirmPasporState extends State<DetailModalKonfirmPaspor> {
  String tglKeluar;
  String tglExp;
  TextEditingController dateKeluar = TextEditingController();
  TextEditingController dateExp = TextEditingController();

  Widget inputNamaPaspor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nama Paspor'),
    );
  }

  Widget inputNomorPaspor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Nomor Paspor'),
    );
  }

  Widget inputLokasiPaspor() {
    return TextFormField(
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Lokasi Pengeluaran Paspor'),
    );
  }

  Widget inputTglKeluar() {
    return TextField(
      controller: dateKeluar,
      decoration: const InputDecoration(
          labelText: 'Tanggal Pengeluaran', border: OutlineInputBorder()),
      onChanged: (String value) {
        tglKeluar = value;
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
            dateKeluar.text = formattedDate;
          });
        }
      },
    );
  }

  Widget inputTglExp() {
    return TextField(
      controller: dateExp,
      decoration: const InputDecoration(
          labelText: 'Tanggal Expired', border: OutlineInputBorder()),
      onChanged: (String value) {
        tglExp = value;
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
            dateExp.text = formattedDate;
          });
        }
      },
    );
  }

  // fncSaveData() {
  //   showDialog(
  //       context: context, builder: (context) => const ModalSaveSuccess());

  //   menuController.changeActiveitemTo('Jadwal');
  //   navigationController.navigateTo('/jamaah/jadwal');
  // }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(children: [
        Form(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 400,
            height: 500,
            child: Column(
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
                        child: Text('Konfirmasi Paspor Nanim Sumartini',
                            style: TextStyle(
                                color: myGrey, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      child: Column(
                        children: [
                          inputNamaPaspor(),
                          const SizedBox(height: 8),
                          inputNomorPaspor(),
                          const SizedBox(height: 8),
                          inputLokasiPaspor(),
                          const SizedBox(height: 8),
                          inputTglKeluar(),
                          const SizedBox(height: 8),
                          inputTglExp(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => const ModalSaveSuccess());
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
