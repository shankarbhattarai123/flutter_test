// To parse this JSON data, do
//
//     final videoList = videoListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VideoList videoListFromJson(String str) => VideoList.fromJson(json.decode(str));

String videoListToJson(VideoList data) => json.encode(data.toJson());

class VideoList {
  VideoList({
    required this.data,
  });

  List<Datum> data;

  factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.url,
    required this.repetation,
  });

  String url;
  int repetation;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        url: json["url"],
        repetation: json["repetation"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "repetation": repetation,
      };
}
