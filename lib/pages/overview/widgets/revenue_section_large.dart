import 'package:flutter/material.dart';
import 'package:flutter_web_course/constants/style.dart';
import 'package:flutter_web_course/widgets/bar_chart.dart';
import 'package:flutter_web_course/widgets/custom_text.dart';
import 'package:flutter_web_course/widgets/revenue_info.dart';
import 'package:intl/intl.dart';

class RevenueSectionLarge extends StatelessWidget {
  const RevenueSectionLarge({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          border: Border.all(color: lightGrey, width: 5)),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: "Revenue Chart",
                size: 20,
                weight: FontWeight.bold,
                color: lightGrey,
              ),
              Container(
                width: 600,
                height: 200,
                child: SimpleBarChart.withSampleData(),
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
                children: [
                  RevenueInfo(
                    title: "Today's revenue",
                    amount: NumberFormat("#,###,000").format(230000000),
                  ),
                  RevenueInfo(
                    title: "Last 7 days",
                    amount: NumberFormat("#,###,000").format(1500000000),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  RevenueInfo(
                    title: "Last 30 days",
                    amount: NumberFormat("#,###,000").format(12030000000),
                  ),
                  RevenueInfo(
                    title: "Last 12 months",
                    amount: NumberFormat("#,###,000").format(32340000000),
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
