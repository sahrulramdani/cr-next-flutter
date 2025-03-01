import 'package:flutter/material.dart';
import 'package:flutter_web_course/widgets/info_card_small.dart';

class OverviewCardSmallScreen extends StatelessWidget {
  const OverviewCardSmallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "Rides in Progress",
            value: "7",
            onTap: () {},
            isActive: true,
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(
            title: "Packages Delivered",
            value: "17",
            onTap: () {},
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(
            title: "Cancelled Delivery",
            value: "3",
            onTap: () {},
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(
            title: "Scheduled Deliveries",
            value: "32",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
