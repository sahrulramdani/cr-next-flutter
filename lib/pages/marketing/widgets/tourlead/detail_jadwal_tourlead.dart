import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
// import 'package:flutter_web_course/constants/dummy.dart';

class DetailJadwalTourlead extends StatelessWidget {
  const DetailJadwalTourlead({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            DataTable(
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
                    label: Text('Pemberangkatan',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Jamaah',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Total',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Dep',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
                DataColumn(
                    label: Text('Info',
                        style: TextStyle(
                            color: myGrey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            fontSize: 16))),
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
                      DataCell(Icon(Icons.calendar_month_outlined,
                          color: Colors.white)),
                      DataCell(Text('Sistem Lama 2017',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                      DataCell(Text(' ')),
                      DataCell(Text(' ')),
                      DataCell(Text(' ')),
                      DataCell(Text(' ')),
                    ]),
                DataRow(cells: [
                  const DataCell(Text('1')),
                  const DataCell(Icon(Icons.check, color: Colors.green)),
                  const DataCell(Text('18 Oktober 2018')),
                  const DataCell(Text('1')),
                  const DataCell(Text('1')),
                  const DataCell(Text('-')),
                  DataCell(IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: myBlue,
                    ),
                    onPressed: () {},
                  )),
                ]),
                DataRow(cells: [
                  const DataCell(Text('2')),
                  const DataCell(Icon(Icons.check, color: Colors.green)),
                  const DataCell(Text('20 Desember 2018')),
                  const DataCell(Text('8')),
                  const DataCell(Text('9')),
                  const DataCell(Text('-')),
                  DataCell(IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: myBlue,
                    ),
                    onPressed: () {},
                  )),
                ]),
                DataRow(cells: [
                  const DataCell(Text('3')),
                  const DataCell(Icon(Icons.check, color: Colors.green)),
                  const DataCell(Text('31 Desember 2018')),
                  const DataCell(Text('4')),
                  const DataCell(Text('13')),
                  const DataCell(Text('-')),
                  DataCell(IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: myBlue,
                    ),
                    onPressed: () {},
                  )),
                ]),
                DataRow(cells: [
                  const DataCell(Text('4')),
                  const DataCell(Icon(Icons.check, color: Colors.green)),
                  const DataCell(Text('05 Januari 2019')),
                  const DataCell(Text('2')),
                  const DataCell(Text('15')),
                  const DataCell(Text('-')),
                  DataCell(IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: myBlue,
                    ),
                    onPressed: () {},
                  )),
                ]),
                DataRow(cells: [
                  const DataCell(Text('5')),
                  const DataCell(Icon(Icons.check, color: Colors.green)),
                  const DataCell(Text('10 Januari 2019')),
                  const DataCell(Text('2')),
                  const DataCell(Text('17')),
                  const DataCell(Text('-')),
                  DataCell(IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: myBlue,
                    ),
                    onPressed: () {},
                  )),
                ]),
                DataRow(cells: [
                  const DataCell(Text('6')),
                  const DataCell(Icon(Icons.check, color: Colors.green)),
                  const DataCell(Text('21 Februari 2019')),
                  const DataCell(Text('1')),
                  const DataCell(Text('1')),
                  DataCell(Icon(Icons.check, color: Colors.grey[900])),
                  DataCell(IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: myBlue,
                    ),
                    onPressed: () {},
                  )),
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
                      DataCell(Icon(Icons.card_giftcard_outlined,
                          color: Colors.white)),
                      DataCell(Text('Kesempatan Berangkat',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                      DataCell(Text(' ')),
                      DataCell(Text(' ')),
                      DataCell(Text(' ')),
                      DataCell(Text(' ')),
                    ]),
                DataRow(cells: [
                  const DataCell(Text('1')),
                  const DataCell(Icon(Icons.check, color: Colors.green)),
                  const DataCell(Text('09 Mei 2019')),
                  const DataCell(Text('3')),
                  const DataCell(Text('4')),
                  const DataCell(Text('-')),
                  DataCell(IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: myBlue,
                    ),
                    onPressed: () {},
                  )),
                ]),
                DataRow(cells: [
                  const DataCell(Text('2')),
                  const DataCell(Icon(Icons.check, color: Colors.green)),
                  const DataCell(Text('20 Desember 2019')),
                  const DataCell(Text('6')),
                  const DataCell(Text('12')),
                  const DataCell(Text('-')),
                  DataCell(IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: myBlue,
                    ),
                    onPressed: () {},
                  )),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
