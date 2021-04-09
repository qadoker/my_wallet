import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_wallet/firebase/models/category.dart';

class CategoryFDB {
  static Future<String> createCategory(Category category) async {
    final doctCategory = FirebaseFirestore.instance
        .collection('userInfo')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('category')
        .doc();

    category.id = doctCategory.id;

    await doctCategory.set(category.toJson());
    return category.id;
  }

  static Future<String> updateCategory(Category category) async {
    final doctCategory = FirebaseFirestore.instance
        .collection('userInfo')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('category')
        .doc(category.id);

    await doctCategory.update(category.toJson());
  }

  static Future<String> deleteCategory(Category category) async {
    final doctCategory = FirebaseFirestore.instance
        .collection('userInfo')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('category')
        .doc(category.id);

    await doctCategory.delete();
  }

  static Stream<List<Category>> readCategories() => FirebaseFirestore.instance
      .collection('userInfo')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('category')
      .orderBy(CategoryField.id, descending: true)
      .snapshots()
      .transform(transformer(Category.fromJson));

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
