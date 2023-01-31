import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
//import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
  const DataTable2SimpleDemo();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      // width: 200,
      // padding: EdgeInsets.all(10),
      // margin: EdgeInsets.symmetric(vertical: 1),
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(8),
      //     boxShadow: [
      //       BoxShadow(
      //           offset: Offset(0, 6),
      //           color: lightGrey.withOpacity(.1),
      //           blurRadius: 12)
      //     ],
      //     border: Border.all(color: lightGrey, width: 5)),
      child: DataTable(
          columns: [
            DataColumn(
                label: Text('Nama Proyek',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
            DataColumn(
                label: Text('Customer',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
            DataColumn(
                label: Text('Tgl. Estimasi',
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
          ],
          rows: //[
              // DataRow(cells: [
              //   DataCell(Container(width: 50, child: Text('Dash'))),
              //   DataCell(Container(width: 50, child: Text('2018'))),
              // ]),
              // DataRow(cells: [
              //   DataCell(Container(width: 50, child: Text('Ali Nadiansyah'))),
              //   DataCell(Container(width: 50, child: Text('2002'))),
              // ]),
              List<DataRow>.generate(
                  7,
                  (index) => DataRow(cells: [
                        DataCell(CustomText(text: "KPWBI - UPS")),
                        DataCell(CustomText(text: "PT. NINDYA BETON")),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: DateFormat('dd MMM yyyy')
                                  .format(DateTime.now())
                                  .toString(),
                            )
                          ],
                        )),
                        DataCell(Container(
                            child: CustomText(
                          text: "Rp. " +
                              NumberFormat('#,###,000').format(1384440000),
                          color: active.withOpacity(.7),
                          weight: FontWeight.bold,
                        ))),
                      ]))
          // ],
          ),
    );
  }
}
