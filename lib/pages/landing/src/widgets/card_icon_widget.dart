import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';

class CardIconLanding extends StatelessWidget {
  final String judul;
  final String icon;
  final String deskripsi;

  const CardIconLanding({Key key, this.judul, this.icon, this.deskripsi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  IconData(int.parse(icon), fontFamily: 'MaterialIcons'),
                  color: myBlue,
                  size: 60,
                ),
                const SizedBox(height: 15),
                Text(judul,
                    style: TextStyle(
                        color: dark,
                        fontSize: screenWidth < 500 ? 15 : 25,
                        fontFamily: 'Gilroy')),
                const SizedBox(height: 10),
                Text(deskripsi,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: screenWidth < 500 ? 10 : 13,
                      fontFamily: 'Gilroy',
                    )),
              ],
            )));
  }
}
