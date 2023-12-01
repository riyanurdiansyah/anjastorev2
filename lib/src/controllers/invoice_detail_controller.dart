import 'package:anjastore/src/models/model.dart';
import 'package:anjastore/src/repositories/invoice_repository.dart';
import 'package:anjastore/utils/app_constanta_empty.dart';
import 'package:get/get.dart';

class InvoiceDetailController extends GetxController {
  final InvoiceRepository invoiceRepository = InvoiceRepositoryImpl();

  final Rx<InvoiceM> invoices = invoiceEmpty.obs;

  Future getInoiceById(String id) async {
    final response = await invoiceRepository.getInvoicesById(id);
    if (response != null) {
      invoices.value = response;
    }
  }
}