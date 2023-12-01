import 'package:anjastore/src/models/product_m.dart';
import 'package:anjastore/src/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../config/app_route.dart';
import '../../utils/utils.dart';

class ProductController extends GetxController {
  final ProductRepository productRepository = ProductRepositoryImpl();

  final RxList<ProductM> products = <ProductM>[].obs;

  final RxList<ProductM> productsSearch = <ProductM>[].obs;

  final Rx<int> page = 1.obs;

  final formKey = GlobalKey<FormState>();

  final tcSearch = TextEditingController();

  final tcNama = TextEditingController();

  final tcKode = TextEditingController();

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        getProducts();
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    tcSearch.dispose();
    tcNama.dispose();
    tcKode.dispose();
    super.onClose();
  }

  void clearTextEditing() {
    tcSearch.clear();
    tcNama.clear();
    tcKode.clear();
  }

  Future getProducts() async {
    products.value = await productRepository.getProducts();

    double pageTemp = 0;
    for (int i = 0; i < products.length; i++) {
      pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
      products[i] = products[i].copyWith(page: pageTemp.ceil());
    }
    products.sort((a, b) => a.name.compareTo(b.name));
  }

  void onSearchProducts(String query) {
    double pageTemp = 0;
    List<ProductM> productsTemp = [];
    if (query.isEmpty) {
      productsTemp.clear();
      productsSearch.clear();
    } else {
      productsTemp = products
          .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < productsTemp.length; i++) {
        pageTemp = (i + 1) / 8;
        productsTemp[i] = productsTemp[i].copyWith(page: pageTemp.ceil());
      }
      productsSearch.value = productsTemp;
      productsSearch.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  void onChangepage(int newValue) {
    page.value = newValue;
  }

  void setProductsToVariable(ProductM oldProduct) {
    tcNama.text = oldProduct.name;
    tcKode.text = oldProduct.code;
  }

  void addProduct() async {
    if (formKey.currentState!.validate()) {
      navigatorKey.currentContext?.pop();
      final body = {
        "id": const Uuid().v4(),
        "name": tcNama.text,
        "code": tcKode.text,
        "created": DateTime.now().toIso8601String(),
        "updated": DateTime.now().toIso8601String(),
      };

      final response = await productRepository.addProduct(body);
      if (response == null) {
        clearTextEditing();
        getProducts();
      }
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        width: 350,
        behavior: SnackBarBehavior.floating,
        content: AppTextNormal.labelW600(
            response ?? "Produk berhasil ditambahkan", 16, Colors.white),
      ));
    }
  }

  void updateProduct(String id) async {
    if (formKey.currentState!.validate()) {
      navigatorKey.currentContext!.pop();
      final body = {
        "id": id,
        "name": tcNama.text,
        "code": tcKode.text,
        "updated": DateTime.now().toIso8601String(),
      };

      final response = await productRepository.updateProduct(body);
      if (response == null) {
        clearTextEditing();
        getProducts();
      }
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        width: 350,
        behavior: SnackBarBehavior.floating,
        content: AppTextNormal.labelW600(
            response ?? "Produk berhasil diubah", 16, Colors.white),
      ));
    }
  }

  void deleteProduct(String id) async {
    navigatorKey.currentContext?.pop();
    final response = await productRepository.deleteProduct(id);
    if (response == null) {
      getProducts();
    }
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      width: 350,
      behavior: SnackBarBehavior.floating,
      content: AppTextNormal.labelW600(
          response ?? "Produk berhasil dihapus", 16, Colors.white),
    ));
  }
}
