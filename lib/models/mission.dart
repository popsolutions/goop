import 'dart:convert';
import 'package:flutter/material.dart';

class MissionModel {
  String title;
  String address;
  String content;
  double price;
  String time;

  MissionModel({
    @required this.title,
    @required this.address,
    @required this.content,
    @required this.price,
    @required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'address': address,
      'content': content,
      'price': price,
      'time': time,
    };
  }

  factory MissionModel.fromMap(Map<String, dynamic> map) {
    return MissionModel(
      title: map['title'],
      address: map['address'],
      content: map['content'],
      price: map['price'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MissionModel.fromJson(String source) =>
      MissionModel.fromMap(json.decode(source));
}
