import 'package:anjastore/src/controllers/expense_controller.dart';
import 'package:anjastore/src/models/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';
import 'widgets/custom_pagination.dart';

class WebExpensePage extends StatelessWidget {
  WebExpensePage({super.key});

  final _eC = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    decoration: BoxDecoration(
                      color: colorPrimaryDark.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextNormal.labelBold(
                            "Note",
                            16,
                            Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: AppTextNormal.labelBold(
                            "Nominal",
                            16,
                            Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: AppTextNormal.labelBold(
                            "Dibuat",
                            16,
                            Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () {
                      List<ExpenseM> expenses = [];
                      if (_eC.expensesSearch.isNotEmpty ||
                          _eC.tcSearch.text.isNotEmpty) {
                        expenses = _eC.expensesSearch
                            .where((e) => e.page == _eC.page.value)
                            .toList();
                      } else {
                        expenses = _eC.expenses
                            .where((e) => e.page == _eC.page.value)
                            .toList();
                      }

                      return Column(
                        children: List.generate(
                          expenses.length,
                          (i) => Column(
                            children: [
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AppTextNormal.labelW500(
                                        expenses[i].note,
                                        16,
                                        colorPrimaryDark,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextNormal.labelW500(
                                        AppCurrency.numberToRupiah(
                                            expenses[i].expense),
                                        16,
                                        colorPrimaryDark,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: AppTextNormal.labelW500(
                                        "${DateFormat.yMMMd('id').add_jm().format(DateTime.parse(expenses[i].created))} WIB",
                                        16,
                                        colorPrimaryDark,
                                        textAlign: TextAlign.center,
                                        maxLines: 4,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: InkWell(
                                        onTap: () => AppDialog.dialogAddExpense(
                                            oldExpense: expenses[i]),
                                        child: const Icon(
                                          Icons.mode_edit_rounded,
                                          size: 20,
                                          color: colorPrimaryDark,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 30,
                                      color: Colors.grey.shade200,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: InkWell(
                                        onTap: () => AppDialog.dialogDanger(
                                          title: "Hapus",
                                          subtitle:
                                              "Yakin ingin menghapus data ini?",
                                          ontap: () =>
                                              _eC.deleteExpense(expenses[i].id),
                                        ),
                                        child: const Icon(
                                          Icons.delete_rounded,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 30,
                                      color: Colors.grey.shade200,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: InkWell(
                                        onTap: () => _eC.imageShowing.value =
                                            expenses[i].image,
                                        child: const Icon(
                                          Icons.double_arrow_rounded,
                                          color: colorPrimaryDark,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 0.6,
                                width: double.infinity,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 45,
                          width: size.width / 6,
                          child: TextFormField(
                            controller: _eC.tcSearch,
                            onChanged: _eC.onSearchExpense,
                            style: GoogleFonts.poppins(
                              height: 1.4,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: "Cari note disini..",
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                wordSpacing: 4,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Obx(() {
                          List<ExpenseM> expenses = [];
                          if (_eC.expensesSearch.isNotEmpty ||
                              _eC.tcSearch.text.isNotEmpty) {
                            expenses = _eC.expensesSearch;
                          } else {
                            expenses = _eC.expenses;
                          }
                          return CustomPagination(
                            currentPage: _eC.page.value,
                            totalPage: (expenses.length / 8).ceil() == 0
                                ? 1
                                : (expenses.length / 8).ceil(),
                            onPageChanged: _eC.onChangepage,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          );
                        }),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                if (_eC.imageShowing.isEmpty) {
                  return const SizedBox();
                }
                return Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: size.height / 2.5,
                        margin: const EdgeInsets.only(left: 16, bottom: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(_eC.imageShowing.value),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: double.infinity,
                        height: 40,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          onPressed: () => _eC.imageShowing.value = "",
                          child: AppTextNormal.labelW600(
                            "TUTUP",
                            16,
                            colorPrimaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => AppDialog.dialogAddExpense(),
        backgroundColor: Colors.blue,
        child: AppTextNormal.labelW600(
          "+",
          30,
          Colors.white,
        ),
      ),
    );
  }
}
