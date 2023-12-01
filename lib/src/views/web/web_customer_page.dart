import 'package:anjastore/src/controllers/customer_controller.dart';
import 'package:anjastore/src/models/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/utils.dart';
import 'widgets/custom_pagination.dart';

class WebCustomerPage extends StatelessWidget {
  WebCustomerPage({super.key});

  final _cC = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
                      "Nama",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "Email",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: AppTextNormal.labelBold(
                      "No. HP",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AppTextNormal.labelBold(
                      "Alamat",
                      16,
                      Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                ],
              ),
            ),
            Obx(
              () {
                List<CustomerM> customers = [];
                if (_cC.customersSearch.isNotEmpty ||
                    _cC.tcSearch.text.isNotEmpty) {
                  customers = _cC.customersSearch
                      .where((e) => e.page == _cC.page.value)
                      .toList();
                } else {
                  customers = _cC.customers
                      .where((e) => e.page == _cC.page.value)
                      .toList();
                }

                return Column(
                  children: List.generate(
                    customers.length,
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
                                  customers[i].name,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  customers[i].email,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: AppTextNormal.labelW500(
                                  customers[i].hp,
                                  16,
                                  colorPrimaryDark,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: AppTextNormal.labelW500(
                                  customers[i].address,
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
                                  onTap: () => AppDialog.dialogAddCustomer(
                                      oldCustomer: customers[i]),
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
                                    subtitle: "Yakin ingin menghapus data ini?",
                                    ontap: () => _cC.deleteCustomer(
                                      customers[i].id,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                      controller: _cC.tcSearch,
                      onChanged: _cC.onSearchCustomers,
                      style: GoogleFonts.poppins(
                        height: 1.4,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "Cari customer disini..",
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
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(() {
                    List<CustomerM> customers = [];
                    if (_cC.customersSearch.isNotEmpty ||
                        _cC.tcSearch.text.isNotEmpty) {
                      customers = _cC.customersSearch;
                    } else {
                      customers = _cC.customers;
                    }
                    return CustomPagination(
                      currentPage: _cC.page.value,
                      totalPage: (customers.length / 8).ceil() == 0
                          ? 1
                          : (customers.length / 8).ceil(),
                      onPageChanged: _cC.onChangepage,
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
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => AppDialog.dialogAddCustomer(),
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
