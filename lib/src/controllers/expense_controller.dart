import 'package:anjastore/src/models/model.dart';
import 'package:anjastore/src/repositories/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../config/app_route.dart';
import '../../utils/utils.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository expenseRepository = ExpenseRepositoryImpl();

  final RxList<ExpenseM> expenses = <ExpenseM>[].obs;

  final RxList<ExpenseM> expensesSearch = <ExpenseM>[].obs;

  final Rx<String> tempId = "".obs;

  final Rx<int> page = 1.obs;

  final Rx<String> imageShowing = "".obs;

  final formKey = GlobalKey<FormState>();

  final tcSearch = TextEditingController();

  final tcNote = TextEditingController();

  final tcNominal = TextEditingController();

  final tcDate = TextEditingController();

  final tcImage = TextEditingController();

  FilePickerResult? selectedFile;

  DateTime? dateExpense;

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
    tcDate.dispose();
    super.onClose();
  }

  void clearTextEditing() {
    tcSearch.clear();
    tcNote.clear();
    tcImage.clear();
    tcNominal.clear();
    tcDate.clear();
    tempId.value = "";
    selectedFile = null;
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

  void onSearchExpense(String query) {
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
    if (formKey.currentState!.validate() && selectedFile != null) {
      tempId.value = const Uuid().v4();
      navigatorKey.currentContext!.pop();
      await expenseRepository.uploadImage(selectedFile!, tempId.value).then(
        (urlImage) async {
          if (urlImage == null) {
            ScaffoldMessenger.of(navigatorKey.currentContext!)
                .showSnackBar(SnackBar(
              width: 350,
              behavior: SnackBarBehavior.floating,
              content: AppTextNormal.labelW600(
                  "Gagal upload foto...", 16, Colors.white),
            ));
          } else {
            final body = {
              "id": tempId.value,
              "note": tcNote.text,
              "image": urlImage,
              "expense": AppCurrency.rupiahToNumber(tcNominal.text),
              "created": DateTime.now().toIso8601String(),
              "updated": DateTime.now().toIso8601String(),
            };

            final response = await expenseRepository.addExpense(body);
            ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
              SnackBar(
                width: 350,
                behavior: SnackBarBehavior.floating,
                content: AppTextNormal.labelW600(
                    response ?? "Pengeluaran berhasil ditambahkan",
                    16,
                    Colors.white),
              ),
            );
            if (response == null) {
              clearTextEditing();
              getExpenses();
            } else {
              expenseRepository.deleteImage(tempId.value);
            }
          }
        },
      );
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

  Future chooseFile() async {
    var picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => debugPrint(status.name),
      allowedExtensions: ["jpg", "png", "jpeg", "webp"],
    );

    if (picked != null) {
      selectedFile = picked;
      tcImage.text = picked.files.first.name;
    }
  }

  Future chooseDate() async {
    final date = await showDatePicker(
        context: navigatorKey.currentContext!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().add(const Duration(days: -365)),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (date != null) {
      final selectedTime = await showTimePicker(
        context: navigatorKey.currentContext!,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (selectedTime != null) {
        dateExpense = DateTime(date.year, date.month, date.day,
            selectedTime.hour, selectedTime.minute);
        tcDate.text =
            "${DateFormat.yMMMd('id').add_jm().format(dateExpense!)} WIB";
      }
    }
  }
}
