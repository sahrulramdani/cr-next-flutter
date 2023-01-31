import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/widgets/revenue_info.dart';
import 'package:flutter_web_course/comp/chart_example.dart';

class RevenueHrLarge extends StatelessWidget {
  const RevenueHrLarge({Key key}) : super(key: key);

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
      child: Row(
        children: [
          Expanded(
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
              )
            ],
          )),
          Container(
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: const [
                  RevenueInfo(
                    title: "Bulan Ini",
                    amount: "29",
                  ),
                  RevenueInfo(
                    title: "Bulan Lalu",
                    amount: "32",
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
                    amount: "114",
                  ),
                  RevenueInfo(
                    title: "Tahun Ini",
                    amount: "240",
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
