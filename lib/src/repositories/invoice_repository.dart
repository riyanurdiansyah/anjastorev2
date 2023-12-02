import 'package:anjastore/src/models/invoice_m.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class InvoiceRepository {
  Future<List<InvoiceM>> getInvoices();

  Future<InvoiceM?> getInvoicesById(String id);

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

  @override
  Future<InvoiceM?> getInvoicesById(String id) async {
    try {
      final response =
          await invoiceCollection.where("kode_invoice", isEqualTo: id).get();
      if (response.docs.isNotEmpty) {
        return InvoiceM.fromJson(response.docs.first.data());
      } else {
        final response2 =
            await invoiceCollection.where("no_invoice", isEqualTo: id).get();
        if (response2.docs.isNotEmpty) {
          return InvoiceM.fromJson(response2.docs.first.data());
        }
        return null;
      }
    } catch (e) {
      debugPrint("ERROR GET INVOICE BY ID : ${e.toString()}");
      return null;
    }
  }
}
