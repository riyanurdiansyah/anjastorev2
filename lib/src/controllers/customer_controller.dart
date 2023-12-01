import 'package:anjastore/config/app_route.dart';
import 'package:anjastore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../models/model.dart';
import '../repositories/customer_repository.dart';

class CustomerController extends GetxController {
  final RxList<CustomerM> customers = <CustomerM>[].obs;

  final RxList<CustomerM> customersSearch = <CustomerM>[].obs;

  final CustomerRepository customerRepository = CustomerRepositoryImpl();

  final formKey = GlobalKey<FormState>();

  final tcSearch = TextEditingController();

  final tcNama = TextEditingController();

  final tcEmail = TextEditingController();

  final tcHp = TextEditingController();

  final tcAddress = TextEditingController();

  final Rx<int> page = 1.obs;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () async {
      getCustomers();
    });
    super.onInit();
  }

  @override
  void dispose() {
    debugPrint("KE DISPOSE");
    super.dispose();
  }

  @override
  void onClose() {
    tcSearch.dispose();
    tcAddress.dispose();
    tcNama.dispose();
    tcEmail.dispose();
    tcHp.dispose();
    super.onClose();
  }

  void clearTextEditing() {
    tcSearch.clear();
    tcAddress.clear();
    tcNama.clear();
    tcHp.clear();
    tcEmail.clear();
  }

  Future getCustomers() async {
    customers.value = await customerRepository.getCustomers();

    double pageTemp = 0;
    for (int i = 0; i < customers.length; i++) {
      pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
      customers[i] = customers[i].copyWith(page: pageTemp.ceil());
    }
    customers.sort((a, b) => a.name.compareTo(b.name));
  }

  void onSearchCustomers(String query) {
    double pageTemp = 0;
    List<CustomerM> customersTemp = [];
    if (query.isEmpty) {
      customersTemp.clear();
      customersSearch.clear();
    } else {
      customersTemp = customers
          .where((e) =>
              e.name.toLowerCase().contains(query.toLowerCase()) ||
              e.email.toLowerCase().contains(query.toLowerCase()) ||
              e.address.toLowerCase().contains(query.toLowerCase()) ||
              e.hp.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < customersTemp.length; i++) {
        pageTemp = (i + 1) / 8;
        customersTemp[i] = customersTemp[i].copyWith(page: pageTemp.ceil());
      }
      customersSearch.value = customersTemp;
      customersSearch.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  void onChangepage(int newValue) {
    page.value = newValue;
  }

  void addCustomer() async {
    if (formKey.currentState!.validate()) {
      navigatorKey.currentContext?.pop();
      final body = {
        "id": const Uuid().v4(),
        "name": tcNama.text,
        "email": tcEmail.text,
        "address": tcAddress.text,
        "created": DateTime.now().toIso8601String(),
        "updated": DateTime.now().toIso8601String(),
        "hp": tcHp.text,
      };

      final response = await customerRepository.addCustomer(body);
      if (response == null) {
        clearTextEditing();
        getCustomers();
      }
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        width: 350,
        behavior: SnackBarBehavior.floating,
        content: AppTextNormal.labelW600(
            response ?? "Customer berhasil ditambahkan", 16, Colors.white),
      ));
    }
  }

  void setCustomerToVariable(CustomerM oldCustomer) {
    tcAddress.text = oldCustomer.address;
    tcNama.text = oldCustomer.name;
    tcHp.text = oldCustomer.hp;
    tcEmail.text = oldCustomer.email;
  }

  void updatedCustomer(String id) async {
    if (formKey.currentState!.validate()) {
      navigatorKey.currentContext?.pop();
      final body = {
        "id": id,
        "name": tcNama.text,
        "email": tcEmail.text,
        "address": tcAddress.text,
        "updated": DateTime.now().toIso8601String(),
        "hp": tcHp.text,
      };

      final response = await customerRepository.addCustomer(body);
      if (response == null) {
        clearTextEditing();
        getCustomers();
      }
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        width: 350,
        behavior: SnackBarBehavior.floating,
        content: AppTextNormal.labelW600(
            response ?? "Customer berhasil diubah", 16, Colors.white),
      ));
    }
  }

  void deleteCustomer(String id) async {
    navigatorKey.currentContext?.pop();
    final response = await customerRepository.deleteCustomer(id);
    if (response == null) {
      getCustomers();
    }
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      width: 350,
      behavior: SnackBarBehavior.floating,
      content: AppTextNormal.labelW600(
          response ?? "Customer berhasil dihapus", 16, Colors.white),
    ));
  }
}
