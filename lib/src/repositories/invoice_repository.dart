import 'package:anjastore/src/models/invoice_m.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class InvoiceRepository {
  Future<List<InvoiceM>> getInvoices();

  Future<String?> addInvoice(Map<String, dynamic> body);

  Future<String?> updateInvoice(Map<String, dynamic> body);

  Future<String?> deleteInvoice(String id);
}

class InvoiceRepositoryImpl implements InvoiceRepository {
  final invoiceCollection = FirebaseFirestore.instance.collection("invoices");

  @override
  Future<String?> addInvoice(Map<String, dynamic> body) async {
    try {
      await invoiceCollection.doc(body["id"]).set(body);
      return null;
    } catch (e) {
      debugPrint("ERROR ADD INVOICE : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<String?> deleteInvoice(String id) async {
    try {
      await invoiceCollection.doc(id).delete();
      return null;
    } catch (e) {
      debugPrint("ERROR DELETE INVOICE : ${e.toString()}");
      return e.toString();
    }
  }

  @override
  Future<List<InvoiceM>> getInvoices() async {
    List<InvoiceM> invoices = [];
    try {
      final response = await invoiceCollection.get();
      for (var data in response.docs) {
        invoices.add(InvoiceM.fromJson(data.data()));
      }

      return invoices;
    } catch (e) {
      debugPrint("ERROR GET INVOICE : ${e.toString()}");
      return invoices;
    }
  }

  @override
  Future<String?> updateInvoice(Map<String, dynamic> body) async {
    try {
      await invoiceCollection.doc(body["id"]).update(body);
      return null;
    } catch (e) {
      debugPrint("ERROR UPDATE INVOICE : ${e.toString()}");
      return e.toString();
    }
  }
}
