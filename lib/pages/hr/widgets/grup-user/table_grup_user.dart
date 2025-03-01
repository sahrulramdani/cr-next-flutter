// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/modal_edit_grup_user.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/modal_hapus_grup_user.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/modal_list_user_grup.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

class ButtonHapus extends StatelessWidget {
  final String idGrup;
  const ButtonHapus({Key key, @required this.idGrup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline_outlined,
        color: authDelt == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authDelt == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalHapusGrupUser(idGrup: idGrup))
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
    );
  }
}

class ButtonEdit extends StatelessWidget {
  final String idGrup;
  const ButtonEdit({Key key, @required this.idGrup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: authEdit == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authEdit == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalEditGrupUser(idGrup: idGrup))
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
    );
  }
}

class ButtonUser extends StatelessWidget {
  String idGrup;
  ButtonUser({Key key, @required this.idGrup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.supervised_user_circle_outlined,
        color: authInqu == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authInqu == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalListUserGrup(idGrup: idGrup))
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> listGrupUser;
  MyData(this.listGrupUser);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listGrupUser[index]['KDXX_GRUP'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listGrupUser[index]['NAMA_GRUP'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(listGrupUser[index]['KETERANGAN'],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(idGrup: listGrupUser[index]['KDXX_GRUP']),
            const SizedBox(width: 10),
            ButtonUser(idGrup: listGrupUser[index]['KDXX_GRUP']),
            const SizedBox(width: 10),
            ButtonHapus(idGrup: listGrupUser[index]['KDXX_GRUP']),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listGrupUser.length;

  @override
  int get selectedRowCount => 0;
}

class TableGrupUser extends StatefulWidget {
  List<Map<String, dynamic>> listGrupUser;
  TableGrupUser({Key key, @required this.listGrupUser}) : super(key: key);

  @override
  State<TableGrupUser> createState() => _TableGrupUserState();
}

class _TableGrupUserState extends State<TableGrupUser> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.listGrupUser);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.63,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columns: const [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Kode Grup',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Grup',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Keterangan',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Expanded(
              child: Center(
                child: Text('Aksi',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16)),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
