// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert';

List<MarketingModel> marketingModelFromJson(String str) =>
    List<MarketingModel>.from(
        json.decode(str).map((x) => MarketingModel.fromJson(x)));

String marketingModelToJson(List<MarketingModel> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class MarketingModel {
  MarketingModel({
    this.NAMA_LGKP,
    this.KDXX_POSX,
  });

  String NAMA_LGKP;
  int KDXX_POSX;

  factory MarketingModel.fromJson(Map<String, dynamic> json) => MarketingModel(
        NAMA_LGKP: json["NAMA_LGKP"],
        KDXX_POSX: json['KDXX_POSX'],
      );

  Map<String, dynamic> toJson() => {
        "NAMA_LGKP": NAMA_LGKP,
        "KDXX_POSX": KDXX_POSX,
      };
}
