// ignore_for_file: must_be_immutable, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/jadwal/modal_hapus_jadwal.dart';
import 'modal_cd_maskapai.dart';
import 'modal_hapus_maskapai.dart';
// import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA

class ButtonEdit extends StatelessWidget {
  String idMaskapai;
  ButtonEdit({
    Key key,
    @required this.idMaskapai,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit_outlined,
        color: authEdit == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authInqu == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalCdMaskapai(
                      idMaskapai: idMaskapai,
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

class ButtonHapus extends StatelessWidget {
  String idMaskapai;
  ButtonHapus({Key key, @required this.idMaskapai}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: authDelt == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authDelt == '1'
            ? showDialog(
                context: context,
                builder: (context) =>
                    ModalHapusMaskapai(idMaskapai: idMaskapai))
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
  final List<Map<String, dynamic>> listMaskapai;
  MyData(this.listMaskapai);

  @override
  DataRow getRow(int index) {
    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return DataRow(cells: [
      DataCell(Text((index + 1).toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      // DataCell(Text(listMaskapai[index]['IDXX_PSWT'].toString())),
      DataCell(Text(listMaskapai[index]['NAMA_PSWT'].toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            ButtonEdit(
              idMaskapai: listMaskapai[index]['IDXX_PSWT'].toString(),
            ),
            const SizedBox(width: 5),
            ButtonHapus(
              idMaskapai: listMaskapai[index]['IDXX_PSWT'].toString(),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listMaskapai.length;

  @override
  int get selectedRowCount => 0;
}

class TableMasterMaskapai extends StatefulWidget {
  final List<Map<String, dynamic>> listMaskapai;
  const TableMasterMaskapai({Key key, @required this.listMaskapai})
      : super(key: key);

  @override
  State<TableMasterMaskapai> createState() => _TableMasterMaskapaiState();
}

class _TableMasterMaskapaiState extends State<TableMasterMaskapai> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.listMaskapai);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.9,
      height: 0.6 * screenHeight,
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
            // DataColumn(
            //     label: Text('ID',
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             fontFamily: 'Gilroy',
            //             fontSize: 16))),
            DataColumn(
                label: Text('Nama',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: SizedBox(
                    width: 80,
                    child: Center(
                      child: Text('Aksi',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy',
                              fontSize: 16)),
                    ))),
          ],
        ),
      ),
    );
  }
}
