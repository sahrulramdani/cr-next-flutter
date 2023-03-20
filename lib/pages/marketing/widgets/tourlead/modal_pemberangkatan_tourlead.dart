import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/detail_berangkat_tourlead.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/detail_jadwal_tourlead.dart';
import 'package:flutter_web_course/pages/marketing/widgets/tourlead/detail_jadwal_pelanggan.dart';

class ModalPemberangkatanTourlead extends StatefulWidget {
  const ModalPemberangkatanTourlead({Key key}) : super(key: key);

  @override
  State<ModalPemberangkatanTourlead> createState() =>
      _ModalPemberangkatanTourleadState();
}

class _ModalPemberangkatanTourleadState
    extends State<ModalPemberangkatanTourlead> {
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
                      child:
                          Column(children: const [DetailBerangkatTourlead()])),
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
