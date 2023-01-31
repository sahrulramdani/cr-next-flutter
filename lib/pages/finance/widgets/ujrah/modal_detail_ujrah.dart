// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/pages/finance/widgets/ujrah/detail_transaksi_ujrah.dart';
import 'package:flutter_web_course/pages/marketing/widgets/pemberangkatan/detail_pemberangkatan_jamaah.dart';

class ModalDetailUjrah extends StatefulWidget {
  const ModalDetailUjrah({Key key}) : super(key: key);

  @override
  State<ModalDetailUjrah> createState() => _ModalDetailUjrahState();
}

class _ModalDetailUjrahState extends State<ModalDetailUjrah> {
  Widget waPemberitahuan() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.chat_outlined),
      label: const Text(
        'WA',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget printBukti() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print Bukti',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget printProses() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.print_outlined),
      label: const Text(
        'Print Proses',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdTransfer() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.credit_card),
      label: const Text(
        'Transfer',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget uploadBT() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.upload_file_outlined),
      label: const Text(
        'Upload BT',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  Widget cmdOtorisasi() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.check_box_outlined),
      label: const Text(
        'Otorisasi',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: myBlue,
        shadowColor: Colors.grey,
        elevation: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: screenWidth * 0.7,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Detail Transaksi Marketing',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Text('Faktur'),
                    SizedBox(width: 10),
                    Text(':'),
                    SizedBox(width: 10),
                    Text('17012023-001'),
                    SizedBox(width: 70),
                    Text('ID Marketing'),
                    SizedBox(width: 10),
                    Text(':'),
                    SizedBox(width: 10),
                    Text('01NEN290675001'),
                    SizedBox(width: 70),
                    Text('Marketing'),
                    SizedBox(width: 10),
                    Text(':'),
                    SizedBox(width: 10),
                    Text('Neni Setiawati'),
                    SizedBox(width: 70),
                    Text('Transaksi'),
                    SizedBox(width: 10),
                    Text(':'),
                    SizedBox(width: 10),
                    Text('39'),
                  ],
                ),
                const SizedBox(height: 10),
                const Expanded(child: DetailTransaksiUjrah()),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      cmdOtorisasi(),
                      const SizedBox(width: 10),
                      uploadBT(),
                      const SizedBox(width: 10),
                      cmdTransfer(),
                      const SizedBox(width: 10),
                      printProses(),
                      const SizedBox(width: 10),
                      printBukti(),
                      const SizedBox(width: 10),
                      waPemberitahuan(),
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
          )
        ],
      ),
    );
  }
}
