import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wallet/firebase/models/operation.dart';

class OperationFDB {
  static Future<String> createOperation(Operation operation) async {
    final doctOperation = FirebaseFirestore.instance
        .collection('userInfo')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('operation')
        .doc();

    operation.id = doctOperation.id;

    await doctOperation.set(operation.toJson());
    return operation.id;
  }

  static Future<String> updateOperation(Operation operation) async {
    final doctOperation = FirebaseFirestore.instance
        .collection('userInfo')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('operation')
        .doc(operation.id);

    await doctOperation.update(operation.toJson());
  }

  static Future<String> deleteOperation(Operation operation) async {
    final doctOperation = FirebaseFirestore.instance
        .collection('userInfo')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('operation')
        .doc(operation.id);

    await doctOperation.delete();
  }

  static Stream<List<Operation>> readOperations() => FirebaseFirestore.instance
      .collection('userInfo')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('operation')
      .orderBy(OperationField.createdTime, descending: true)
      .snapshots()
      .transform(transformer(Operation.fromJson));

  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();

          sink.add(objects);
        },
      );
}
