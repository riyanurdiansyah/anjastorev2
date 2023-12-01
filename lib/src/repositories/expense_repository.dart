import 'package:anjastore/src/models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseM>> getExpenses();

  Future<String?> addExpense(Map<String, dynamic> body);

  Future<String?> updateExpense(Map<String, dynamic> body);

  Future<String?> deleteExpense(String id);

  Future<String?> uploadImage(FilePickerResult file, String id);

  Future<String?> deleteImage(String id);
}

class ExpenseRepositoryImpl implements ExpenseRepository {
  final expenseCollection = FirebaseFirestore.instance.collection("expenses");

  @override
  Future<String?> addExpense(Map<String, dynamic> body) async {
    try {
      await expenseCollection.doc(body["id"]).set(body);
      return null;
    } catch (e) {
      debugPrint("ERROR ADD EXPENSE : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<String?> deleteExpense(String id) async {
    try {
      await expenseCollection.doc(id).delete();
      return null;
    } catch (e) {
      debugPrint("ERROR DELETE EXPENSE : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<List<ExpenseM>> getExpenses() async {
    List<ExpenseM> expenses = [];
    try {
      final response = await expenseCollection.get();
      for (var data in response.docs) {
        expenses.add(ExpenseM.fromJson(data.data()));
      }
      return expenses;
    } catch (e) {
      debugPrint("ERROR ADD EXPENSE : ${e.toString()}");
      return expenses;
    }
  }

  @override
  Future<String?> updateExpense(Map<String, dynamic> body) async {
    try {
      await expenseCollection.doc(body["id"]).update(body);
      return null;
    } catch (e) {
      debugPrint("ERROR UPDATE EXPENSE : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<String?> uploadImage(FilePickerResult file, String id) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('expenses/$id.jpg');

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      UploadTask uploadTask =
          storageRef.putData(file.files.first.bytes!, metadata);
      return await ((await uploadTask).ref.getDownloadURL());
    } catch (e) {
      debugPrint("ERROR UPLOAD FILE : ${e.toString()}");
      return null;
    }
  }

  @override
  Future<String?> deleteImage(String id) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('images')
          .child('expenses/$id.jpg')
          .delete();

      return null;
    } catch (e) {
      debugPrint("ERROR DELETE FILE : ${e.toString()}");
      return e.toString();
    }
  }
}
