import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OperationField {
  static const createdTime = 'createdTime';
}

class Operation {
  DateTime createdTime;
  String id;
  String price;
  String categoryName;
  int categoryIconVal;

  Operation({
    @required this.createdTime,
    this.id,
    this.price,
    this.categoryName,
    this.categoryIconVal
  });

  static Operation fromJson(Map<String, dynamic> json) => Operation(
    createdTime: toDateTime(json['createdTime']),
    id: json['id'],
    price: json['price'],
    categoryName: json['categoryName'],
    categoryIconVal: json['categoryIconVal']
  );

  Map<String, dynamic> toJson() => {
    'createdTime': fromDateTimeToJson(createdTime),
    'id' : id,
    'price' : price,
    'categoryName' : categoryName,
    'categoryIconVal' : categoryIconVal
  };

  static DateTime toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

}