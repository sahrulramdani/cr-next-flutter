import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/controllers/func_all.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/detail_berangkat_tourlead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModalPemberangkatanTourlead extends StatefulWidget {
  const ModalPemberangkatanTourlead({Key key}) : super(key: key);

  @override
  State<ModalPemberangkatanTourlead> createState() =>
      _ModalPemberangkatanTourleadState();
}

class _ModalPemberangkatanTourleadState
    extends State<ModalPemberangkatanTourlead> {
  List<Map<String, dynamic>> listTourleader = [];

  void getPemberangkatanTourleader() async {
    var response = await http.get(
        Uri.parse("$urlAddress/marketing/tourlead/all-jadwal-tl"),
        headers: {
          'pte-token': kodeToken,
        });
    List<Map<String, dynamic>> data =
        List.from(json.decode(response.body) as List);

    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        if (i == 0 || data[i]['TGLX_BGKT'] != data[(i - 1)]['TGLX_BGKT']) {
          var info = {
            "JENS_ROWS": "F",
            "NAMA_LGKP":
                "Akan Berangkat ${fncGetTanggal(data[i]['TGLX_BGKT'])}",
            "GRADE_TL": "",
            "JAMAAH": "",
            "TUGAS": "",
          };

          listTourleader.add(info);
        }

        var arr = {
          "JENS_ROWS": "X",
          "NAMA_LGKP": "${data[i]['NAMA_LGKP']}",
          "GRADE_TL": "${data[i]['LEVEL_TL']}",
          "JAMAAH": "${data[i]['PERD_JMAH']}",
          "TUGAS": "${data[i]['JENS_MRKT']}",
        };

        listTourleader.add(arr);
      }
    }

    // SIAP BERANGKAT
    var response2 = await http
        .get(Uri.parse("$urlAddress/marketing/tourlead/tl-siap"), headers: {
      'pte-token': kodeToken,
    });
    List<Map<String, dynamic>> data2 =
        List.from(json.decode(response2.body) as List);

    if (data2.isNotEmpty) {
      var info2 = {
        "JENS_ROWS": "Y",
        "NAMA_LGKP": "Siap Berangkat",
        "GRADE_TL": "",
        "JAMAAH": "",
        "TUGAS": "",
      };

      listTourleader.add(info2);

      for (var j = 0; j < data2.length; j++) {
        var arr2 = {
          "JENS_ROWS": "Z",
          "NAMA_LGKP": "${data2[j]['NAMA_LGKP']}",
          "GRADE_TL": "${data2[j]['FIRST_LEVEL']}",
          "JAMAAH": "${data2[j]['PERD_JMAH']}",
          "TUGAS": "Ditentukan",
        };

        listTourleader.add(arr2);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    getPemberangkatanTourleader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: ResponsiveWidget.isSmallScreen(context)
                ? screenWidth * 0.9
                : screenWidth * 0.6,
            height: 700,
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.personal_injury_outlined,
                        color: Colors.amber[900],
                      ),
                      const SizedBox(width: 10),
                      Text('Pemberangkatan Tourleader',
                          style: TextStyle(
                              color: myGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        DetailBerangkatTourlead(
                          listTourleader: listTourleader,
                        )
                      ])),
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
