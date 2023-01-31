import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/widgets/revenue_info.dart';
import 'package:flutter_web_course/comp/chart_example.dart';
import 'package:intl/intl.dart';

class RevenueHrSmall extends StatelessWidget {
  const RevenueHrSmall({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(0.2),
              blurRadius: 12)
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Karyawan 2022",
                  size: 20,
                  weight: FontWeight.bold,
                  color: myBlue,
                ),
                SizedBox(
                  width: 600,
                  height: 200,
                  child: MyCharts.withSampleData(),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          SizedBox(
            height: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    RevenueInfo(
                      title: "Karyawan",
                      amount: "240",
                    ),
                    RevenueInfo(
                      title: "Agen",
                      amount: "114",
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    RevenueInfo(
                      title: "Cabang",
                      amount: "80",
                    ),
                    RevenueInfo(
                      title: "Tour Leader",
                      amount: "42",
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
