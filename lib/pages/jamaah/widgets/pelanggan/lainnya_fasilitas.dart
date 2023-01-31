// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class LainnyaFasilitas extends StatelessWidget {
  const LainnyaFasilitas({Key key}) : super(key: key);

  Widget inputPaspor() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Paspor",
        mode: Mode.MENU,
        onChanged: (value) {},
        items: const [
          "Pembuatan Baru / Kolektif Kantor",
          "Berita Acara Pemeriksaan",
          "Perpanjang",
          "Tambah Kata Nama",
          "Telah Diterima Dikantor",
          "Proses Sendiri / Pending Paspor",
        ],
        selectedItem: "Pembuatan Baru / Kolektif Kantor",
      ),
    );
  }

  Widget inputVaksin() {
    return SizedBox(
      height: 50,
      child: DropdownSearch(
        label: "Vaksin",
        mode: Mode.MENU,
        onChanged: (value) {},
        items: const [
          "Kolektif Kantor",
          "Proses Sendiri",
        ],
        selectedItem: "Kolektif Kantor",
      ),
    );
  }

  Widget inputBiayaFasilitas() {
    return TextFormField(
      textAlign: TextAlign.right,
      onChanged: (value) {},
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      initialValue: '2,000,000',
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Biaya'),
    );
  }

  Widget inputKurs() {
    return TextFormField(
      textAlign: TextAlign.right,
      onChanged: (value) {},
      keyboardType: TextInputType.number,
      inputFormatters: [ThousandsFormatter()],
      style: const TextStyle(fontFamily: 'Gilroy', fontSize: 15),
      initialValue: '15,600',
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Kurs'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Uang Masuk : IDR.28,900,000',
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
                SizedBox(width: 10),
                Text(
                  'Sisa Bayar : IDR.0',
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 30),
            inputPaspor(),
            const SizedBox(height: 8),
            inputVaksin(),
            const SizedBox(height: 8),
            inputBiayaFasilitas(),
            const SizedBox(height: 8),
            inputKurs(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
