// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_edit_jamaah.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_hapus_jamaah.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_upload_jamaah.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ButtonEdit extends StatelessWidget {
  String idJamaah;
  ButtonEdit({Key key, @required this.idJamaah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalEditJamaah(idJamaah: idJamaah));
      },
    );
  }
}

class ButtonChat extends StatelessWidget {
  const ButtonChat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.chat_outlined,
        color: myBlue,
      ),
      onPressed: () => launch(
          'https://api.whatsapp.com/send/?phone=62895616007743&text&type=phone_number&app_absent=0'),
    );
  }
}

class ButtonHapus extends StatelessWidget {
  const ButtonHapus({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context, builder: (context) => const ModalHapusJamaah());
      },
    );
  }
}

class ButtonUpload extends StatelessWidget {
  const ButtonUpload({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.upload_outlined,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context, builder: (context) => const ModalUploadJamaah());
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataJamaah;
  MyData(this.dataJamaah);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(dataJamaah[index]['NOXX_IDNT'].toString())),
      DataCell(Text(dataJamaah[index]['NAMA_LGKP'])),
      DataCell(Text(dataJamaah[index]['NAMA_AYAH'])),
      DataCell(Text(dataJamaah[index]['JENS_KLMN'] == 'P' ? 'Pria' : 'Wanita')),
      DataCell(Text(dataJamaah[index]['TMPT_LHIR'] +
          ', ' +
          DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(dataJamaah[index]['TGLX_LHIR'])))),
      DataCell(Text(dataJamaah[index]['ALAMAT'])),
      DataCell(Text(dataJamaah[index]['NOXX_TELP'].toString())),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idJamaah: dataJamaah[index]['NOXX_IDNT'].toString(),
            ),
            const ButtonChat(),
            const ButtonUpload(),
            const ButtonHapus(),
            // SizedBox(
            //   width: 5,
            // ),
            // ButtonHapus(),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataJamaah.length;

  @override
  int get selectedRowCount => 0;
}

class TableMasterJamaah extends StatefulWidget {
  List<Map<String, dynamic>> dataJamaah;

  TableMasterJamaah({Key key, @required this.dataJamaah}) : super(key: key);

  @override
  State<TableMasterJamaah> createState() => _TableMasterJamaahState();
}

class _TableMasterJamaahState extends State<TableMasterJamaah> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.dataJamaah);

    return SizedBox(
      width: screenWidth,
      height: 0.41 * screenHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 15.0,
          source: myTable,
          columns: [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('NIK',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Lengkap',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Ayah',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('JK',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('TTL',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Alamat',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Telepon',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16)),
                    )))
          ],
        ),
      ),
    );
  }
}
