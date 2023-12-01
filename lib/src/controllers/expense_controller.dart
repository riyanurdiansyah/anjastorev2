import 'package:anjastore/src/models/model.dart';
import 'package:anjastore/src/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../config/app_route.dart';
import '../../utils/utils.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository expenseRepository = ExpenseRepositoryImpl();

  final RxList<ExpenseM> expenses = <ExpenseM>[].obs;

  final RxList<ExpenseM> expensesSearch = <ExpenseM>[].obs;

  final Rx<int> page = 1.obs;

  final formKey = GlobalKey<FormState>();

  final tcSearch = TextEditingController();

  final tcNote = TextEditingController();

  final tcNominal = TextEditingController();

  final tcImage = TextEditingController();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () async {
      getExpenses();
    });
    super.onInit();
  }

  @override
  void onClose() {
    tcSearch.dispose();
    tcNote.dispose();
    tcImage.dispose();
    tcNominal.dispose();
    super.onClose();
  }

  void clearTextEditing() {
    tcSearch.clear();
    tcNote.clear();
    tcImage.clear();
    tcNominal.clear();
  }

  Future getExpenses() async {
    expenses.value = await expenseRepository.getExpenses();

    double pageTemp = 0;
    for (int i = 0; i < expenses.length; i++) {
      pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
      expenses[i] = expenses[i].copyWith(page: pageTemp.ceil());
    }
    expenses.sort((a, b) =>
        DateTime.parse(b.created).compareTo(DateTime.parse(a.created)));
  }

  void onSearchProducts(String query) {
    double pageTemp = 0;
    List<ExpenseM> expensesTemp = [];
    if (query.isEmpty) {
      expensesTemp.clear();
      expensesSearch.clear();
    } else {
      expensesTemp = expenses
          .where((e) => e.note.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < expensesTemp.length; i++) {
        pageTemp = (i + 1) / 8;
        expensesTemp[i] = expensesTemp[i].copyWith(page: pageTemp.ceil());
      }
      expensesSearch.value = expensesTemp;
      expensesSearch.sort((a, b) =>
          DateTime.parse(b.created).compareTo(DateTime.parse(a.created)));
    }
  }

  void onChangepage(int newValue) {
    page.value = newValue;
  }

  void setExpenseToVariable(ExpenseM oldExpense) {
    tcNote.text = oldExpense.note;
    tcImage.text = oldExpense.image;
    tcNominal.text = oldExpense.expense.toString();
  }

  void addExpense() async {
    if (formKey.currentState!.validate()) {
      navigatorKey.currentContext!.pop();
      final body = {
        "id": const Uuid().v4(),
        "note": tcNote.text,
        "image": tcImage.text,
        "expense": tcNominal.text,
        "created": DateTime.now().toIso8601String(),
        "updated": DateTime.now().toIso8601String(),
      };

      final response = await expenseRepository.addExpense(body);
      if (response == null) {
        clearTextEditing();
        getExpenses();
      }
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        width: 350,
        behavior: SnackBarBehavior.floating,
        content: AppTextNormal.labelW600(
            response ?? "Pengeluaran berhasil ditambahkan", 16, Colors.white),
      ));
    }
  }

  void updateExpense(String id) async {
    if (formKey.currentState!.validate()) {
      navigatorKey.currentContext!.pop();
      final body = {
        "id": id,
        "note": tcNote.text,
        "image": tcImage.text,
        "expense": tcNominal.text,
        "updated": DateTime.now().toIso8601String(),
      };

      final response = await expenseRepository.updateExpense(body);
      if (response == null) {
        clearTextEditing();
        getExpenses();
      }
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        width: 350,
        behavior: SnackBarBehavior.floating,
        content: AppTextNormal.labelW600(
            response ?? "Pengeluaran berhasil diubah", 16, Colors.white),
      ));
    }
  }

  void deleteExpense(String id) async {
    navigatorKey.currentContext?.pop();
    final response = await expenseRepository.deleteExpense(id);
    if (response == null) {
      getExpenses();
    }
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      width: 350,
      behavior: SnackBarBehavior.floating,
      content: AppTextNormal.labelW600(
          response ?? "Pengeluaran berhasil dihapus", 16, Colors.white),
    ));
  }
}
