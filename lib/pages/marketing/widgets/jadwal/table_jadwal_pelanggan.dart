import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:intl/intl.dart';

/// Example without a datasource
// MYDATA
class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataJadwalPel;
  MyData(this.dataJadwalPel);

  @override
  DataRow getRow(int index) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(
        Checkbox(
          value: false,
          onChanged: (bool value) {},
        ),
      ),
      DataCell(Text(dataJadwalPel[index]['nama_lengkap'].toString())),
      DataCell(Text(dataJadwalPel[index]['jenis_kelamin'].toString())),
      DataCell(Text(dataJadwalPel[index]['umur'].toString())),
      DataCell(Text(dataJadwalPel[index]['an_paspor'] == 'a' ? 'REDY' : 'NON')),
      DataCell(
          Text(dataJadwalPel[index]['status_vaksin'] == 'a' ? 'KOL' : 'NON')),
      DataCell(
          Text(dataJadwalPel[index]['status_handling'] == 'a' ? 'LKP' : 'BLM')),
      DataCell(Text(dataJadwalPel[index]['telepon'].toString())),
      DataCell(Text(
          myFormat.format(int.parse(dataJadwalPel[index]['estimasitotal'])))),
      DataCell(Text(
          myFormat.format(int.parse(dataJadwalPel[index]['dpe_uangmasuk'])))),
      DataCell(Text(
          myFormat.format(int.parse(dataJadwalPel[index]['estimasisisa'])))),
      DataCell(Text(dataJadwalPel[index]['dpe_status'].toString())),
      DataCell(Text(dataJadwalPel[index]['syarat'].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataJadwalPel.length;

  @override
  int get selectedRowCount => 0;
}

class TableJadwalPelanggan extends StatefulWidget {
  final List<Map<String, dynamic>> dataJadwalPel;
  const TableJadwalPelanggan({Key key, @required this.dataJadwalPel})
      : super(key: key);

  @override
  State<TableJadwalPelanggan> createState() => _TableJadwalPelangganState();
}

class _TableJadwalPelangganState extends State<TableJadwalPelanggan> {
  @override
  Widget build(BuildContext context) {
    final DataTableSource myTable = MyData(widget.dataJadwalPel);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.7,
      height: 0.5 * screenHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
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
                label: Text('#',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama',
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
                label: Text('U',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Pasp',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Vaksin',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Hand',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Telp',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Est. Total',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Uang Masuk',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Sisa Bayar',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Lunas',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Cetak',
                    style: TextStyle(
                        color: myGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
