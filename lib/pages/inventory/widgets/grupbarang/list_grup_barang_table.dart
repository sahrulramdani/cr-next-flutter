// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/constants/dummy.dart';
import 'package:flutter_web_course/pages/inventory/widgets/grupbarang/modal_list_grup.dart';
// import 'package:flutter_web_course/pages/marketing/widgets/modal_konfirmasi_pemberangkatan.dart';

class ListGrupBarangTable extends StatelessWidget {
  List<Map<String, dynamic>> listBarangGrupTable;
  String namaGrup;

  ListGrupBarangTable(
      {Key key, @required this.listBarangGrupTable, @required this.namaGrup})
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
            // int x = 1;
            return DataRow(cells: [
              const DataCell(Text('-')),
              DataCell(Text(data['kode_barang'])),
              DataCell(Text(data['nama_barang'])),
              DataCell(Text(data['qty'])),
              DataCell(Text(data['satuan'])),
              DataCell(Text(data['keterangan'])),
              DataCell(IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: myBlue,
                ),
                onPressed: () {
                  listBarangGrup.removeWhere(
                      (item) => item['kode_barang'] == data['kode_barang']);

                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) => ModalListGrup(namaGrup: namaGrup));
                },
              )),
            ]);
          }).toList()),
    );
  }
}
