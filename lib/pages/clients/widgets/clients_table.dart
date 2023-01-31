import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';

/// Example without a datasource
class ClientsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
          columns: [
            DataColumn(
                label: Text('Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
            DataColumn(
                label: Text('Location',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
            DataColumn(
                label: Text('Rating',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
            DataColumn(
                label: Text('Action',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
          ],
          rows: List<DataRow>.generate(
              7,
              (index) => DataRow(cells: [
                    DataCell(CustomText(text: "Santos Enoque")),
                    DataCell(CustomText(text: "New yourk city")),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: "4.$index",
                        )
                      ],
                    )),
                    DataCell(Container(
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: active, width: .5),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: CustomText(
                          text: "Block Client",
                          color: active.withOpacity(.7),
                          weight: FontWeight.bold,
                        ))),
                  ]))
          // ],
          ),
    );
  }
}
