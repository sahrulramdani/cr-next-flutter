import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Example without a datasource
class MyDataTables extends StatelessWidget {
  const MyDataTables({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: const [
          DataColumn(
              label: Text('ID Agency',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
          DataColumn(
              label: Text('Nama Agen',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
          DataColumn(
              label: Text('Fee Level',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
          DataColumn(
              label: Text('Status',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
          DataColumn(
              label: Text('Tgl. Bergabung',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
          DataColumn(
              label: Text('Nilai Rp.',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
          DataColumn(
              label: Text('Total',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
        ],
        rows: //[
            List<DataRow>.generate(
                7,
                (index) => DataRow(cells: [
                      const DataCell(Text("AGX0100001")),
                      const DataCell(Text("Indrawari Prawidya")),
                      const DataCell(Text("AGEN")),
                      const DataCell(Text("Aktif")),
                      DataCell(Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy')
                                .format(DateTime.now())
                                .toString(),
                          )
                        ],
                      )),
                      DataCell(Text(
                        "Rp. ${NumberFormat('#,###,000').format(1384440000)}",
                      )),
                      DataCell(Text(
                        "Rp. ${NumberFormat('#,###,000').format(1384440000)}",
                      )),
                    ]))
        // ],
        );
  }
}
