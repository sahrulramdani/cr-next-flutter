import 'package:flutter/material.dart';

class MyCardInfo extends StatelessWidget {
  final String title;
  final String total;

  const MyCardInfo({this.title, this.total, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 250,
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        image: const DecorationImage(
            fit: BoxFit.cover, image: AssetImage('images/box-background.png')),
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
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  total,
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
