import 'package:flutter/material.dart';
import 'package:flutter_web_course/widgets/info_card.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  const OverviewCardsMediumScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: "Rides in Progress",
              value: "7",
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Packages Delivered",
              value: "17",
              onTap: () {},
              topColor: Colors.lightGreen,
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            InfoCard(
              title: "Cancelled Delivery",
              value: "3",
              onTap: () {},
              topColor: Colors.redAccent,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Scheduled Deliveries",
              value: "32",
              onTap: () {},
              topColor: Colors.orange,
            ),
          ],
        )
      ],
    );
  }
}
