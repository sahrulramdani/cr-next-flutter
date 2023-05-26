import 'package:flutter/material.dart';
import 'package:flutter_web_course/comp/modal_save_fail.dart';
import 'package:flutter_web_course/comp/modal_save_success.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/models/http_tourleader.dart';
import 'package:flutter_web_course/pages/hr/widgets/grup-user/detail_modal_info.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/modal_hapus_jadwal_tourlead.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/modal_tambah_jadwal_tl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModalJadwalTourleader extends StatefulWidget {
  const ModalJadwalTourleader({Key key}) : super(key: key);

  @override
  State<ModalJadwalTourleader> createState() => _ModalJadwalTourleaderState();
}

class _ModalJadwalTourleaderState extends State<ModalJadwalTourleader> {
  List<Map<String, dynamic>> listJadwalTL = [];

  void getJadwalTL() async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/tourlead/all-jadwal-tl"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    if (data.isNotEmpty) {
      for (var j = 0; j < data.length; j++) {
        var pushData = {
          "KDXX_JDTL": "${data[j]['KDXX_JDTL']}",
          "KDXX_JDWL":
              "${data[j]['KDXX_JDWL'] != data[j == 0 ? 0 : j - 1]['KDXX_JDWL'] ? data[j]['KDXX_JDWL'] : (j == 0 ? data[j]['KDXX_JDWL'] : '')}",
          "JENS_PAKET":
              "${data[j]['KDXX_JDWL'] != data[j == 0 ? 0 : j - 1]['KDXX_JDWL'] ? data[j]['JENS_PAKET'] : (j == 0 ? data[j]['JENS_PAKET'] : '')}",
          "KETERANGAN":
              "${data[j]['KDXX_JDWL'] != data[j == 0 ? 0 : j - 1]['KDXX_JDWL'] ? data[j]['KETERANGAN'] : (j == 0 ? data[j]['KETERANGAN'] : '')}",
          "TGLX_BGKT":
              "${data[j]['KDXX_JDWL'] != data[j == 0 ? 0 : j - 1]['KDXX_JDWL'] ? data[j]['TGLX_BGKT'] : (j == 0 ? data[j]['TGLX_BGKT'] : '')}",
          "KDXX_MRKT": "${data[j]['KDXX_MRKT']}",
          "JENS_MRKT": "${data[j]['JENS_MRKT']}",
          "NAMA_LGKP": "${data[j]['NAMA_LGKP']}",
          "LEVEL_TL": "${data[j]['LEVEL_TL']}",
        };

        listJadwalTL.add(pushData);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    getJadwalTL();
    super.initState();
  }

  Widget cmdTambahJadwalTL() {
    return ElevatedButton.icon(
      onPressed: () {
        authAddx == '1'
            ? showDialog(
                context: context,
                builder: (context) => const ModalTambahJadwalTL())
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
      icon: const Icon(Icons.add),
      style: fncButtonAuthStyle(authAddx, context),
      label: fncLabelButtonStyle('Jadwal TL', context),
    );
  }

  Widget cmdHapusJadwalTL(idTugas) {
    return IconButton(
      icon: Icon(
        Icons.delete_forever_outlined,
        color: authDelt == '1' ? myBlue : Colors.blue[200],
      ),
      onPressed: () {
        authDelt == '1'
            ? showDialog(
                context: context,
                builder: (context) => ModalHapusJadwalTL(idTugas: idTugas))
            : showDialog(
                context: context,
                builder: (context) => const ModalInfo(
                      deskripsi: 'Anda Tidak Memiliki Akses',
                    ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int i = 1;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: ResponsiveWidget.isSmallScreen(context)
                ? screenWidth * 0.9
                : screenWidth * 0.7,
            height: 700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.personal_injury_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Jadwal Pemberangkatan Tourleader',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                cmdTambahJadwalTL(),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 35,
                        headingRowHeight: 30,
                        dataRowHeight: 30,
                        headingRowColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          return myBlue;
                        }),
                        headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy',
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        dataTextStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Gilroy',
                            fontSize: 12),
                        columns: const [
                          DataColumn(label: Text('No.')),
                          DataColumn(label: Text('Tanggal Berangkat')),
                          DataColumn(label: Text('Jenis Paket')),
                          DataColumn(label: Text('Keterangan')),
                          DataColumn(label: Text('Nama TL')),
                          DataColumn(label: Text('Level TL')),
                          DataColumn(label: Text('Tugas')),
                          DataColumn(label: Text('Aksi')),
                        ],
                        rows: listJadwalTL.map((e) {
                          return DataRow(cells: [
                            DataCell(Text((i++).toString())),
                            DataCell(Text(e['TGLX_BGKT'] == ''
                                ? ''
                                : fncGetTanggal(e['TGLX_BGKT']))),
                            DataCell(Text(e['JENS_PAKET'])),
                            DataCell(Text(e['KETERANGAN'])),
                            DataCell(Text(e['NAMA_LGKP'])),
                            DataCell(Text(e['LEVEL_TL'])),
                            DataCell(Text(e['JENS_MRKT'])),
                            DataCell(cmdHapusJadwalTL(e['KDXX_JDTL'])),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
