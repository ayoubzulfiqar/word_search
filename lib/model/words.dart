// To parse this JSON data, do
//
//     final words = wordsFromJson(jsonString);
import 'dart:convert';

import 'package:flutter/cupertino.dart';

// Method- 1

// @immutable
// class Names {
//   List<String>? names;

//   Names({this.names});

//   Names.fromJson(Map<String, dynamic> json) {
//     names = json['names'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['names'] = this.names;
//     return data;
//   }
// }

// Method - 2

// To parse this JSON data, do
//
//     final words = wordsFromJson(jsonString);

Words wordsFromJson(String str) => Words.fromJson(json.decode(str));

String wordsToJson(Words data) => json.encode(data.toJson());

@immutable
class Words {
  final List<String> names;
  const Words({
    required this.names,
  });

  Words copyWith({
    List<String>? names,
  }) =>
      Words(
        names: names ?? this.names,
      );

  factory Words.fromJson(Map<String, dynamic> json) => Words(
        names: List<String>.from(json["names"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "names": List<dynamic>.from(names.map((x) => x)),
      };
}
