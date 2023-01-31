import 'package:flutter/material.dart';

class DatatableProyek extends StatefulWidget {
  //final String itemNama;
  DatatableProyek({Key key}) : super(key: key);

  @override
  State<DatatableProyek> createState() => _DatatableProyekState();
}

class _DatatableProyekState extends State<DatatableProyek> {
  List<Menu> data = [];

  @override
  void initState() {
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {}
}

//The Menu Model
class Menu {
  int level = 0;
  IconData icon = Icons.drive_file_rename_outline;
  String title = "Sub Menu";
  List<Menu> children = [];
  //default constructor
  Menu(this.level, this.icon, this.title, this.children);

  //one method for  Json data
  Menu.fromJson(Map<String, dynamic> json) {
    //level
    if (json["level"] != null) {
      level = json["level"];
    }
    //icon
    if (json["icon"] != null) {
      icon = json["icon"];
    }
    //title
    title = json['title'];
    //children
    if (json['children'] != null) {
      children.clear();
      //for each entry from json children add to the Node children
      json['children'].forEach((v) {
        children.add(Menu.fromJson(v));
      });
    }
  }
}

//menu data list
List dataList = [
//menu data item

  {
    "proyek": "PP-UPS JABAR",
    "customer": "PEMPROV JABAR",
    "tglestimasi": "2022-03-01",
    "nilai": 1305000000,
  },

  //menu data item
  {
    "proyek": "PP-UPS JATIM",
    "customer": "PEMPROV JATIM",
    "tglestimasi": "2022-03-01",
    "nilai": 1305000000,
  },

  //menu data item
  {
    "proyek": "PP-UPS JATENG",
    "customer": "PEMPROV JATENG",
    "tglestimasi": "2022-03-01",
    "nilai": 1305000000,
  },

  //menu data item
  {
    "proyek": "PP-UPS SUMUT",
    "customer": "PEMPROV SUMUT",
    "tglestimasi": "2022-03-01",
    "nilai": 1305000000,
  },

  //menu data item
  {
    "proyek": "PP-UPS SUMBAR",
    "customer": "PEMPROV SUMBAR",
    "tglestimasi": "2022-03-01",
    "nilai": 1305000000,
  },
];
