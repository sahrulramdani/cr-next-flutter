// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/pages/inventory/widgets/barang/modal_detail_barang.dart';
import 'package:flutter_web_course/pages/inventory/widgets/barang/modal_edit_barang.dart';
import 'package:flutter_web_course/pages/inventory/widgets/barang/modal_hapus_barang.dart';
import 'package:flutter_web_course/pages/inventory/widgets/barang/modal_stok_barang.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_edit_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jadwal.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_hapus_jamaah.dart';
// import 'package:flutter_web_course/pages/jamaah/widgets/modal_upload_jamaah.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';

class ButtonEdit extends StatelessWidget {
  String idBarang;
  ButtonEdit({Key key, @required this.idBarang}) : super(key: key);

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
            builder: (context) => ModalEditBarang(idBarang: idBarang));
      },
    );
  }
}

class ButtonHapus extends StatelessWidget {
  String idBarang;
  ButtonHapus({Key key, @required this.idBarang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalHapusBarang(idBarang: idBarang));
      },
    );
  }
}

class ButtonStok extends StatelessWidget {
  String idBarang;

  ButtonStok({Key key, @required this.idBarang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.playlist_add_outlined,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalStokBarang(
                  idBarang: idBarang,
                ));
      },
    );
  }
}

class ButtonDetail extends StatelessWidget {
  String idBarang;
  ButtonDetail({Key key, @required this.idBarang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info_outline,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalDetailBarang(idBarang: idBarang));
      },
    );
  }
}

class MyData extends DataTableSource {
  NumberFormat myformat = NumberFormat.decimalPattern('en_us');
  final List<Map<String, dynamic>> dataBarang;
  MyData(this.dataBarang);

  @override
  DataRow getRow(int index) {
    return DataRow(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return int.parse(dataBarang[index]['STOK_BRGX'].toString()) < 10
              ? Colors.red[100]
              : Colors.transparent;
        }),
        cells: [
          DataCell(Text((index + 1).toString())),
          DataCell(Text(dataBarang[index]['KDXX_BRGX'].toString())),
          DataCell(Text(dataBarang[index]['NAMA_BRGX'].toString())),
          DataCell(Text(dataBarang[index]['STOK_BRGX'].toString())),
          DataCell(Text(dataBarang[index]['NAMA_STAN'].toString())),
          DataCell(Text(myformat.format(dataBarang[index]['HRGX_BELI']))),
          DataCell(Text(myformat.format(dataBarang[index]['HRGX_JUAL']))),
          DataCell(Text(dataBarang[index]['KETERANGAN'].toString())),
          DataCell(Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonStok(
                  idBarang: dataBarang[index]['KDXX_BRGX'].toString(),
                ),
                const SizedBox(width: 10),
                ButtonEdit(idBarang: dataBarang[index]['KDXX_BRGX'].toString()),
                const SizedBox(width: 10),
                ButtonDetail(
                    idBarang: dataBarang[index]['KDXX_BRGX'].toString()),
                const SizedBox(width: 10),
                ButtonHapus(
                    idBarang: dataBarang[index]['KDXX_BRGX'].toString()),
              ],
            ),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataBarang.length;

  @override
  int get selectedRowCount => 0;
}

class TableBarang extends StatefulWidget {
  final List<Map<String, dynamic>> listDataBarang;

  const TableBarang({Key key, @required this.listDataBarang}) : super(key: key);

  @override
  State<TableBarang> createState() => _TableBarangState();
}

class _TableBarangState extends State<TableBarang> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.listDataBarang);

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.41,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 5.0,
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
                label: Text('Stok',
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
                label: Text('Harga Beli',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Harga Jual',
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
                label: Expanded(
              child: Center(
                child: Text('Aksi',
                    style: TextStyle(
                        color: myGrey,
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
