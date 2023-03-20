import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/constants/dummy.dart';

class DetailBerangkatTourlead extends StatelessWidget {
  const DetailBerangkatTourlead({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('No.', style: styleColumn)),
                  DataColumn(label: Text('#', style: styleColumn)),
                  DataColumn(label: Text('Nama', style: styleColumn)),
                  DataColumn(label: Text('Grade', style: styleColumn)),
                  DataColumn(label: Text('Jamaah', style: styleColumn)),
                  DataColumn(label: Text('Status', style: styleColumn)),
                ],
                rows: [
                  DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Colors.blue;
                      }),
                      cells: const [
                        DataCell(Text('-',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                        DataCell(Icon(Icons.flight_takeoff_rounded,
                            color: Colors.white)),
                        DataCell(Text('Akan Berangkat 17 Februari 2023',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                        DataCell(Text(' ')),
                        DataCell(Text(' ')),
                        DataCell(Text(' ')),
                      ]),
                  const DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(
                        Icon(Icons.how_to_reg_outlined, color: Colors.green)),
                    DataCell(Text('Daud Salam')),
                    DataCell(Text('Ahli')),
                    DataCell(Text('-')),
                    DataCell(Text('Pembimbing')),
                  ]),
                  const DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(
                        Icon(Icons.how_to_reg_outlined, color: Colors.green)),
                    DataCell(Text('Titi Kamala')),
                    DataCell(Text('Pemula')),
                    DataCell(Text('40')),
                    DataCell(Text('Terbimbing')),
                  ]),
                  DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Colors.green[700];
                      }),
                      cells: const [
                        DataCell(Text('-',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                        DataCell(Icon(Icons.play_lesson_outlined,
                            color: Colors.white)),
                        DataCell(Text('Siap Berangkat',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                        DataCell(Text(' ')),
                        DataCell(Text(' ')),
                        DataCell(Text(' ')),
                      ]),
                  const DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Icon(Icons.library_add_check_outlined,
                        color: Colors.deepOrange)),
                    DataCell(Text('Billy Syahputra')),
                    DataCell(Text('Mahir')),
                    DataCell(Text('-')),
                    DataCell(Text('Pembimbing')),
                  ]),
                  const DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Icon(Icons.library_add_check_outlined,
                        color: Colors.deepOrange)),
                    DataCell(Text('Susilo')),
                    DataCell(Text('Mahir')),
                    DataCell(Text('-')),
                    DataCell(Text('Pembimbing')),
                  ]),
                  const DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Icon(Icons.library_add_check_outlined,
                        color: Colors.deepOrange)),
                    DataCell(Text('Dedi Kusna')),
                    DataCell(Text('Pemula')),
                    DataCell(Text('40')),
                    DataCell(Text('Terbimbing')),
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
