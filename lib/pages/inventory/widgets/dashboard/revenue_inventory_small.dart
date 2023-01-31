import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/widgets/revenue_info.dart';
import 'package:flutter_web_course/comp/chart_example.dart';
import 'package:intl/intl.dart';

class RevenueInventorySmall extends StatelessWidget {
  const RevenueInventorySmall({Key key}) : super(key: key);

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
                  text: "Barang Keluar 2022",
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
                      title: "Bulan Ini",
                      amount: "283",
                    ),
                    RevenueInfo(
                      title: "Bulan Lalu",
                      amount: "318",
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    RevenueInfo(
                      title: "6 Bulan",
                      amount: "672",
                    ),
                    RevenueInfo(
                      title: "Tahun Ini",
                      amount: "891",
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
