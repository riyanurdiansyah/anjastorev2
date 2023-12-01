import 'package:anjastore/src/models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseM>> getExpenses();

  Future<String?> addExpense(Map<String, dynamic> body);

  Future<String?> updateExpense(Map<String, dynamic> body);

  Future<String?> deleteExpense(String id);
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
}
