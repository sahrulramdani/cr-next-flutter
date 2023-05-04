import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/helpers/responsiveness.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotFindWidget extends StatefulWidget {
  final String description;
  const NotFindWidget({key, @required this.description}) : super(key: key);

  @override
  State<NotFindWidget> createState() => _NotFindWidgetState();
}

class _NotFindWidgetState extends State<NotFindWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth < 500 ? screenWidth * 0.8 : screenWidth * 0.6,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.15,
            child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/images/hero-alert-fail.png',
                )),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      widget.description,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const FittedBox(
                    child: Text(
                      'Kamu Bisa Bertanya Untuk Mengetahui Paket Yang Tersedia',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
