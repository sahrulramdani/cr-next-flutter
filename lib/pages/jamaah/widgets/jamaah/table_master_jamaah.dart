// ignore_for_file: must_be_immutable, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_edit_jamaah.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_hapus_jamaah.dart';
import 'package:flutter_web_course/pages/jamaah/widgets/jamaah/modal_upload_jamaah.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ButtonEdit extends StatelessWidget {
  String idJamaah;
  ButtonEdit({Key key, @required this.idJamaah}) : super(key: key);

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
            builder: (context) => ModalEditJamaah(idJamaah: idJamaah));
      },
    );
  }
}

class ButtonChat extends StatelessWidget {
  String telepon;
  String nama;
  String jk;
  ButtonChat({
    Key key,
    @required this.telepon,
    @required this.nama,
    @required this.jk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.chat_outlined,
        color: myBlue,
      ),
      onPressed: () => launch(
          'https://api.whatsapp.com/send/?phone=$telepon&text=Assalamualaikum+Wr.+Wb.%0A$jk+$nama+sehat+%3F%0AKami+dari+Travel+Cahaya+Raudhah+%0ABerhubungan+dengan+Umroh+di+Arab+Saudi+sementara+belum+di+buka+kami+memproduksi+atau+menjual+beberapa+produk+baru+%0AYaitu+berupa+%3A+%0A1.+Air+Zamzam+%0A2.+Madu+Randu+%0A3.+Madu+Hitam+%0A4.+Madu+Putih+Sumbawa+%0A5.+Madu+Beragam+Lainnya+%0ADan+juga+%3A+%0A1.+Sabun+Pencuci+Piring+%0A2.+Sabun+Detergen+%0A3.+Sabun+Pembersih+Lantai+Sereh+%0A4.+Sabun+Softener+Pakaian+%0A5.+Dan+sebagainya+%0AJika+$jk+$nama+berminat+kami+siap+antar+ke+rumah+gratis+ongkir+sampai+rumah+%0ATerimakasih+sudah+memilih+travel+Cahaya+Raudhah.+%0ASalam+dari+kami+keluarga+besar+PT.+Cahaya+Raudhah+%0AWassalamualaikum+Wr.+Wb.&type=phone_number&app_absent=0'),
    );
  }
}

class ButtonHapus extends StatelessWidget {
  String idJamaah;
  ButtonHapus({Key key, @required this.idJamaah}) : super(key: key);

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
            builder: (context) => ModalHapusJamaah(idJamaah: idJamaah));
      },
    );
  }
}

class ButtonUpload extends StatelessWidget {
  String idJamaah;
  ButtonUpload({Key key, @required this.idJamaah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.image_search_outlined,
        color: myBlue,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => ModalUploadJamaah(
                  idJamaah: idJamaah,
                ));
      },
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> dataJamaah;
  MyData(this.dataJamaah);

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((index + 1).toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataJamaah[index]['NOXX_IDNT'].toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataJamaah[index]['NAMA_LGKP'] ?? '-',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataJamaah[index]['NAMA_AYAH'] ?? '-',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataJamaah[index]['JENS_KLMN'] == 'P' ? 'Pria' : 'Wanita',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(
          dataJamaah[index]['TMPT_LHIR'] ??
              '-' +
                  ', ' +
                  DateFormat("dd-MM-yyyy")
                      .format(DateTime.parse(dataJamaah[index]['TGLX_LHIR'])),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataJamaah[index]['ALAMAT'] ?? '-',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Text(dataJamaah[index]['NOXX_TELP'].toString(),
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]))),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonEdit(idJamaah: dataJamaah[index]['NOXX_IDNT'].toString()),
            ButtonChat(
                jk: dataJamaah[index]['JENS_KLMN'] == 'P' ? 'Pak' : 'Bu',
                nama: dataJamaah[index]['NAMA_LGKP']
                    .toString()
                    .replaceAll(' ', '+'),
                telepon: fncTelp(
                  dataJamaah[index]['NOXX_TELP'].toString(),
                )),
            ButtonUpload(idJamaah: dataJamaah[index]['NOXX_IDNT'].toString()),
            ButtonHapus(idJamaah: dataJamaah[index]['NOXX_IDNT'].toString()),
            // SizedBox(
            //   width: 5,
            // ),
            // ButtonHapus(),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataJamaah.length;

  @override
  int get selectedRowCount => 0;
}

class TableMasterJamaah extends StatefulWidget {
  List<Map<String, dynamic>> dataJamaah;

  TableMasterJamaah({Key key, @required this.dataJamaah}) : super(key: key);

  @override
  State<TableMasterJamaah> createState() => _TableMasterJamaahState();
}

class _TableMasterJamaahState extends State<TableMasterJamaah> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final DataTableSource myTable = MyData(widget.dataJamaah);

    return SizedBox(
      width: screenWidth,
      height: 0.41 * screenHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columnSpacing: 15.0,
          source: myTable,
          columns: const [
            DataColumn(
                label: Text('No.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('NIK',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Lengkap',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Nama Ayah',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Jenis Kelamin',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('TTL',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Alamat',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 16))),
            DataColumn(
                label: Text('Telepon',
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
                    )))
          ],
        ),
      ),
    );
  }
}
