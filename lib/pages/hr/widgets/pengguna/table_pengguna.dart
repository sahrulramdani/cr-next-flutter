// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/hr/widgets/pengguna/modal_akses_pengguna.dart';
import 'package:flutter_web_course/pages/hr/widgets/pengguna/modal_edit_pengguna.dart';
import 'package:flutter_web_course/pages/hr/widgets/pengguna/modal_hapus_pengguna.dart';

class ButtonHapus extends StatelessWidget {
  String idPengguna;
  ButtonHapus({Key key, @required this.idPengguna}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline_rounded,
        color: authDelt == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authDelt == '1'
            ? showDialog(
                context: context,
                builder: (context) =>
                    ModalHapusPengguna(idPengguna: idPengguna))
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
  String idPengguna;
  String namaPengguna;
  ButtonEdit({Key key, @required this.idPengguna, @required this.namaPengguna})
      : super(key: key);

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
                builder: (context) => ModalEditPengguna(
                      idPengguna: idPengguna,
                      namaPengguna: namaPengguna,
                    ))
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
  String idPengguna;
  String namaPengguna;
  ButtonUser({Key key, @required this.idPengguna, @required this.namaPengguna})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.playlist_add_check_circle_outlined,
        color: authEdit == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authEdit == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalAksesPengguna(
                      idPengguna: idPengguna,
                      namaPengguna: namaPengguna,
                    ))
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
  final List<Map<String, dynamic>> listPengguna;
  MyData(this.listPengguna);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(), style: styleRowReguler)),
      DataCell(Text(listPengguna[index]['USER_IDXX'], style: styleRowReguler)),
      DataCell(Text(listPengguna[index]['KETX_USER'], style: styleRowReguler)),
      DataCell(Text(listPengguna[index]['NAMA_GRUP'], style: styleRowReguler)),
      DataCell(
          Text(listPengguna[index]['LOGIN_TERAKHIR'], style: styleRowReguler)),
      DataCell(Text(listPengguna[index]['ACTIVE'] == '1' ? 'Aktif' : 'Nonaktif',
          style: styleRowReguler)),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(
              idPengguna: listPengguna[index]['USER_IDXX'],
              namaPengguna: listPengguna[index]['USER_IDXX'],
            ),
            const SizedBox(width: 10),
            ButtonUser(
                idPengguna: listPengguna[index]['USER_IDXX'],
                namaPengguna: listPengguna[index]['USER_IDXX']),
            const SizedBox(width: 10),
            ButtonHapus(idPengguna: listPengguna[index]['USER_IDXX']),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listPengguna.length;

  @override
  int get selectedRowCount => 0;
}

class TablePengguna extends StatefulWidget {
  List<Map<String, dynamic>> listPengguna;
  TablePengguna({Key key, @required this.listPengguna}) : super(key: key);

  @override
  State<TablePengguna> createState() => _TablePenggunaState();
}

class _TablePenggunaState extends State<TablePengguna> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.listPengguna);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.63,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          source: myTable,
          columns: const [
            DataColumn(label: Text('No.', style: styleColumn)),
            DataColumn(label: Text('Username', style: styleColumn)),
            DataColumn(label: Text('Nama User', style: styleColumn)),
            DataColumn(label: Text('Grup', style: styleColumn)),
            DataColumn(label: Text('Login Terakhir', style: styleColumn)),
            DataColumn(label: Text('Status', style: styleColumn)),
            DataColumn(
                label: Expanded(
              child: Center(
                child: Text('Aksi', style: styleColumn),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
