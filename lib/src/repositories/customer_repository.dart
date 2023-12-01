import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/customer_m.dart';

abstract class CustomerRepository {
  Future<List<CustomerM>> getCustomers();

  Future<String?> addCustomer(Map<String, dynamic> body);

  Future<String?> updateCustomer(Map<String, dynamic> body);

  Future<String?> deleteCustomer(String id);
}

class CustomerRepositoryImpl implements CustomerRepository {
  final customerCollection = FirebaseFirestore.instance.collection("customers");

  @override
  Future<List<CustomerM>> getCustomers() async {
    try {
      List<CustomerM> customers = [];

      final response = await customerCollection.get();
      if (response.docs.isNotEmpty) {
        for (var data in response.docs) {
          customers.add(CustomerM.fromJson(data.data()));
        }

        return customers;
      }
      return [];
    } catch (e) {
      debugPrint("ERROR GET CUSTOMER : ${e.toString()}");
      return [];
    }
  }

  @override
  Future<String?> addCustomer(Map<String, dynamic> body) async {
    try {
      await customerCollection.doc(body["id"]).set(body);
      return null;
    } catch (e) {
      debugPrint("ERROR ADD CUSTOMER : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<String?> updateCustomer(Map<String, dynamic> body) async {
    try {
      await customerCollection.doc(body["id"]).update(body);
      return null;
    } catch (e) {
      debugPrint("ERROR UPDATE CUSTOMER : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<String?> deleteCustomer(String id) async {
    try {
      await customerCollection.doc(id).delete();
      return null;
    } catch (e) {
      debugPrint("ERROR DELETE CUSTOMER : ${e.toString()}");
      return e.toString();
    }
  }
}
