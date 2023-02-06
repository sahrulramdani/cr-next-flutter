// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/models/http_grup_barang.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_list_grup.dart';

import '../../../../comp/modal_delete_success.dart';
import '../../../../constants/controllers.dart';
// import 'package:flutter_web_course/pages/marketing/widgets/modal_konfirmasi_pemberangkatan.dart';

class ListGrupBarangTable extends StatelessWidget {
  List<Map<String, dynamic>> listBarangGrupTable;
  // String namaGrup;

  ListGrupBarangTable({Key key, @required this.listBarangGrupTable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1075,
      child: DataTable(
          border: TableBorder.all(color: Colors.grey),
          columns: [
            DataColumn(
                label: Text('#',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Kode Barang',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Barang',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Qty',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Satuan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Keterangan',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Aksi',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
          ],
          rows: listBarangGrupTable.map((data) {
            return DataRow(cells: [
              DataCell(Text("-")),
              DataCell(Text(data['KDXX_BRGX'].toString())),
              DataCell(Text(data['NAMA_BRGX'].toString())),
              DataCell(Text(data['QTYX_BRGX'].toString())),
              DataCell(Text(data['NAMA_STAN'].toString())),
              DataCell(Text(data['KETERANGAN'].toString())),
              DataCell(IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: myBlue,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  HttpGrupBarang.deleteGrupBarangDetail(
                          data['KDXX_GRUP'].toString(),
                          data['KDXX_BRGX'].toString())
                      .then((value) {
                    if (value.status == true) {
                      showDialog(
                          context: context,
                          builder: (context) => const ModalDeleteSuccess());
                      // menuController.changeActiveitemTo('Grup Barang');
                      // navigationController.navigateTo('/inventory/grup-barang');
                    }
                  });
                  // Http
                  // showDialog(
                  //     context: context,
                  //     builder: (context) => ModalListGrup(namaGrup: namaGrup));
                },
              )),
            ]);
          }).toList()),
    );
  }
}
