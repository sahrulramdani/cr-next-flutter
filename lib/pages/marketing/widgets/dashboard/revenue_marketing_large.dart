import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/widgets/revenue_info.dart';
import 'package:flutter_web_course/comp/chart_example.dart';
import 'package:intl/intl.dart';

class RevenueMarketingLarge extends StatelessWidget {
  const RevenueMarketingLarge({Key key}) : super(key: key);

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
                text: "Perolehan Jamaah",
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
                    title: "Pusat",
                    amount: "46",
                  ),
                  RevenueInfo(
                    title: "Agen",
                    amount: "215",
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
                    amount: "183",
                  ),
                  RevenueInfo(
                    title: "Tour Leader",
                    amount: "40",
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
