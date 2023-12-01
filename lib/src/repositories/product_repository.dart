import 'package:anjastore/src/models/product_m.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class ProductRepository {
  Future<List<ProductM>> getProducts();

  Future<String?> addProduct(Map<String, dynamic> body);

  Future<String?> updateProduct(Map<String, dynamic> body);

  Future<String?> deleteProduct(String id);
}

class ProductRepositoryImpl implements ProductRepository {
  final productCollection = FirebaseFirestore.instance.collection("products");

  @override
  Future<String?> addProduct(Map<String, dynamic> body) async {
    try {
      await productCollection.doc(body["id"]).set(body);
      return null;
    } catch (e) {
      debugPrint("ERROR ADD PRODUCT : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<String?> deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      return null;
    } catch (e) {
      debugPrint("ERROR DELETE PRODUCT : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<List<ProductM>> getProducts() async {
    List<ProductM> products = [];
    try {
      final response = await productCollection.get();
      if (response.docs.isNotEmpty) {
        for (var data in response.docs) {
          products.add(ProductM.fromJson(data.data()));
        }
      }
      return products;
    } catch (e) {
      debugPrint("ERROR ADD PRODUCT : ${e.toString()}");
      return products;
    }
  }

  @override
  Future<String?> updateProduct(Map<String, dynamic> body) async {
    try {
      await productCollection.doc(body["id"]).update(body);
      return null;
    } catch (e) {
      debugPrint("ERROR UPDATE PRODUCT : ${e.toString()}");
      return e.toString();
    }
  }
}
