// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_course/pages/marketing/widgets/pemberangkatan/detail_pemberangkatan_jamaah.dart';

class ModalEditPemberangkatan extends StatefulWidget {
  String idJadwal;
  ModalEditPemberangkatan({Key key, @required this.idJadwal}) : super(key: key);

  @override
  State<ModalEditPemberangkatan> createState() =>
      _ModalEditPemberangkatanState();
}

class _ModalEditPemberangkatanState extends State<ModalEditPemberangkatan> {
  Widget spacePemisah() {
    return const SizedBox(
      height: 10,
      width: 10,
    );
  }

  Widget selectInput() {
    return SizedBox(
      height: 40,
      width: 200,
      child: DropdownSearch(
        mode: Mode.MENU,
        items: const ["Semua", "Hasan Basri", "Baihaqi", "Munawaroh"],
        onChanged: print,
        selectedItem: "Semua",
      ),
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

  Widget menuButton() => Container(
        height: 50,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            selectInput(),
            spacePemisah(),
            cmdPrint(),
          ],
        ),
      );

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
                      Text('Jadwal 02 Januari 2023 Umroh',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                menuButton(),
                const SizedBox(height: 10),
                Expanded(
                    child:
                        DetailPemberangkatanJamaah(idJadwal: widget.idJadwal)),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
