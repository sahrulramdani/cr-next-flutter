import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';

class RevenueInfo extends StatelessWidget {
  final String title;
  final String amount;

  const RevenueInfo({Key key, this.title, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              text: "$title \n\n",
              style: TextStyle(
                  color: myGrey,
                  fontSize: 18,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.normal)),
          TextSpan(
              text: " $amount ",
              style: TextStyle(
                color: dark,
                fontSize: 30,
                fontWeight: FontWeight.w300,
                fontFamily: 'Gilroy',
              )),
        ]),
      ),
    ));
  }
}
