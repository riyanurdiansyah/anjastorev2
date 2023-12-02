import 'package:anjastore/src/models/model.dart';
import 'package:anjastore/src/repositories/invoice_repository.dart';
import 'package:anjastore/utils/app_constanta_empty.dart';
import 'package:get/get.dart';

import '../repositories/customer_repository.dart';

class InvoiceDetailController extends GetxController {
  final InvoiceRepository invoiceRepository = InvoiceRepositoryImpl();

  final CustomerRepository customerRepository = CustomerRepositoryImpl();

  final Rx<InvoiceM> invoices = invoiceEmpty.obs;

  final RxList<CustomerM> customers = <CustomerM>[].obs;

  final Rx<String> invoiceId = "".obs;

  final Rx<String> messageError = "".obs;

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        await getCustomers();
        getInoiceById(invoiceId.value);
      },
    );
    super.onInit();
  }

  Future getCustomers() async {
    messageError.value = "";
    customers.value = await customerRepository.getCustomers();
  }

  Future getInoiceById(String id) async {
    final response = await invoiceRepository.getInvoicesById(id);
    if (response != null) {
      invoices.value = response;
    } else {
      messageError.value = "Invoice tidak ditemukan";
    }
  }
}
