import 'dart:math';

import 'package:anjastore/config/app_route.dart';
import 'package:anjastore/src/models/model.dart';
import 'package:anjastore/src/repositories/invoice_repository.dart';
import 'package:anjastore/src/repositories/repository.dart';
import 'package:anjastore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class InvoiceController extends GetxController {
  final CustomerRepository customerRepository = CustomerRepositoryImpl();

  final ProductRepository productRepository = ProductRepositoryImpl();

  final InvoiceRepository invoiceRepository = InvoiceRepositoryImpl();

  final Rx<ProductM> selectedProduct = productEmpty.obs;

  final Rx<CustomerM> selectedCustomer = customerEmpty.obs;

  final RxList<InvoiceM> invoices = <InvoiceM>[].obs;
  final RxList<InvoiceM> invoicesSearch = <InvoiceM>[].obs;

  final RxList<CustomerM> customers = <CustomerM>[].obs;

  final RxList<InvoiceItemM> invoicesItem = <InvoiceItemM>[].obs;

  final formKey = GlobalKey<FormState>();
  final formKeyItems = GlobalKey<FormState>();

  final tcSearch = TextEditingController();

  final tcHpCustomer = TextEditingController();
  final tcEmailCustomer = TextEditingController();

  DateTime? dateInvoice;
  DateTime? dateInvoiceTempo;
  final tcDP = TextEditingController();
  final tcSisaTagihan = TextEditingController();
  final tcDate = TextEditingController();
  final tcDateTempo = TextEditingController();

  final tcHargaProduk = TextEditingController();
  final tcQtyProduk = TextEditingController(text: "1");
  final tcJumlahHargaProduk = TextEditingController(text: "0");
  final tcDeskripsiProduk = TextEditingController();

  final tcNote = TextEditingController();

  final tcNominal = TextEditingController();

  final tcImage = TextEditingController();

  final Rx<int> page = 1.obs;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () async {
      await getCustomers();
      await getInvoices();
    });
    super.onInit();
  }

  @override
  void onClose() {
    tcDP.dispose();
    tcSisaTagihan.dispose();
    tcDate.dispose();
    tcDateTempo.dispose();
    tcNote.dispose();
    tcNominal.dispose();
    tcImage.dispose();
    tcHargaProduk.dispose();
    tcQtyProduk.dispose();
    tcJumlahHargaProduk.dispose();
    tcDeskripsiProduk.dispose();
    super.onClose();
  }

  Future getCustomers() async {
    customers.value = await customerRepository.getCustomers();
  }

  Future getInvoices() async {
    invoices.value = await invoiceRepository.getInvoices();
    double pageTemp = 0;
    for (int i = 0; i < invoices.length; i++) {
      pageTemp = (i + 1) ~/ 8 < 1 ? 1 : (i + 1) / 8;
      invoices[i] = invoices[i].copyWith(page: pageTemp.ceil());
    }
    invoices.sort((a, b) => DateTime.parse(b.tanggalTerima)
        .compareTo(DateTime.parse(a.tanggalTerima)));
  }

  void onSearchInvoices(String query) {
    double pageTemp = 0;
    List<InvoiceM> invoicesTemp = [];
    if (query.isEmpty) {
      invoicesTemp.clear();
      invoicesSearch.clear();
    } else {
      invoicesTemp = invoices
          .where((e) => e.noInvoice.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < invoicesTemp.length; i++) {
        pageTemp = (i + 1) / 8;
        invoicesTemp[i] = invoicesTemp[i].copyWith(page: pageTemp.ceil());
      }
      invoicesSearch.value = invoicesTemp;
      invoicesSearch.sort((a, b) => a.noInvoice.compareTo(b.noInvoice));
    }
  }

  void clearTextEditing() {
    tcDP.clear();
    tcSisaTagihan.clear();
    tcDate.clear();
    tcDateTempo.clear();
    tcNote.clear();
    tcNominal.clear();
    tcImage.clear();
    tcHargaProduk.clear();
    tcQtyProduk.clear();
    tcJumlahHargaProduk.clear();
    tcDeskripsiProduk.clear();
    selectedProduct.value = productEmpty;
  }

  void onSelectCustomer(CustomerM? newCustomer) {
    if (newCustomer != null) {
      selectedCustomer.value = newCustomer;
      tcHpCustomer.text = newCustomer.hp;
      tcEmailCustomer.text = newCustomer.email;
    }
  }

  void calculateAmountItem() {
    final hargaPerPcs = AppCurrency.rupiahToNumber(tcHargaProduk.text);
    final qty = int.parse(tcQtyProduk.text.isEmpty ? "0" : tcQtyProduk.text);

    tcJumlahHargaProduk.text = AppCurrency.numberToRupiah((hargaPerPcs * qty));
  }

  void saveItem() {
    if (formKeyItems.currentState!.validate() &&
        selectedProduct.value != productEmpty) {
      navigatorKey.currentContext!.pop();
      invoicesItem.add(
        InvoiceItemM(
          idProduk: selectedProduct.value.id,
          deskripsi: tcDeskripsiProduk.text,
          jumlahHarga: AppCurrency.rupiahToNumber(tcJumlahHargaProduk.text),
          namaProduk: selectedProduct.value.name,
          qty: int.parse(tcQtyProduk.text),
          satuanHarga: AppCurrency.rupiahToNumber(
            tcHargaProduk.text,
          ),
        ),
      );
      Future.delayed(const Duration(milliseconds: 400), () {
        clearTextEditing();
        calculateSisaTagihan();
      });
    }
  }

  void onSelectProduct(ProductM? newValue) {
    if (newValue != null) {
      selectedProduct.value = newValue;
    }
  }

  void calculateSisaTagihan() {
    int total = 0;

    for (int i = 0; i < invoicesItem.length; i++) {
      total += invoicesItem[i].jumlahHarga;
      if (i == (invoicesItem.length - 1)) {
        tcSisaTagihan.text = AppCurrency.numberToRupiah(total);
      }
    }

    if (tcDP.text.isNotEmpty) {
      tcSisaTagihan.text = AppCurrency.numberToRupiah(
          (AppCurrency.rupiahToNumber(tcSisaTagihan.text) -
              AppCurrency.rupiahToNumber(tcDP.text)));
    }
  }

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  Future chooseDate() async {
    final date = await showDatePicker(
        context: navigatorKey.currentContext!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().add(const Duration(days: -365)),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (date != null) {
      final selectedTime = await showTimePicker(
        context: navigatorKey.currentContext!,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (selectedTime != null) {
        dateInvoice = DateTime(date.year, date.month, date.day,
            selectedTime.hour, selectedTime.minute);
        dateInvoiceTempo = DateTime(date.year, date.month, date.day,
            selectedTime.hour, selectedTime.minute);

        int daysToAdd = 0;
        while (daysToAdd < 14) {
          dateInvoiceTempo = dateInvoiceTempo!.add(const Duration(days: 1));
          if (!isWeekend(dateInvoiceTempo!)) {
            daysToAdd++;
          }
        }
        tcDate.text =
            "${DateFormat.yMMMd('id').add_jm().format(dateInvoice!)} WIB";
        tcDateTempo.text =
            "${DateFormat.yMMMd('id').add_jm().format(dateInvoiceTempo!)} WIB";
      }
    }
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future addInvoice() async {
    if (formKey.currentState!.validate() && invoicesItem.isNotEmpty) {
      navigatorKey.currentContext!.pop();
      final frmtDate = DateFormat("ddMMyyyy").format(
          DateTime(dateInvoice!.year, dateInvoice!.month, dateInvoice!.day));
      int totalHarga = 0;
      int noInvoice = 0;

      if (invoices
          .where((e) => e.noInvoice.contains(frmtDate))
          .toList()
          .isNotEmpty) {
        noInvoice = invoices
                .where((e) => e.noInvoice.contains(frmtDate))
                .toList()
                .length +
            1;
      } else {
        noInvoice = noInvoice + 1;
      }

      for (var data in invoicesItem) {
        totalHarga += data.jumlahHarga;
      }

      final body = {
        "id": const Uuid().v4(),
        "kode_invoice": getRandomString(10),
        "tanggal_terima": dateInvoice!.toIso8601String(),
        "jatuh_tempo": dateInvoiceTempo!.toIso8601String(),
        "dp": AppCurrency.rupiahToNumber(tcDP.text),
        "sisa_tagihan": AppCurrency.rupiahToNumber(tcSisaTagihan.text),
        "id_customer": selectedCustomer.value.id,
        "items": invoicesItem.map((e) => e.toJson()).toList(),
        "total_harga": totalHarga,
        "no_invoice": "INV/$frmtDate/TRX/$noInvoice",
        "no": invoices.length + 1,
      };

      final response = await invoiceRepository.addInvoice(body);
      if (response == null) {
        clearTextEditing();
        getInvoices();
      }
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        width: 350,
        behavior: SnackBarBehavior.floating,
        content: AppTextNormal.labelW600(
            response ?? "Invoice berhasil ditambahkan", 16, Colors.white),
      ));
    }
  }

  void onChangepage(int newValue) {
    page.value = newValue;
  }

  void setOldDataToVariable(CustomerM oldCustomer, InvoiceM oldInvoice) {
    onSelectCustomer(oldCustomer);
    invoicesItem.value = oldInvoice.items;
    tcDP.text = AppCurrency.numberToRupiah(oldInvoice.dp);
    tcSisaTagihan.text = AppCurrency.numberToRupiah(oldInvoice.sisaTagihan);
    dateInvoice = DateTime.parse(oldInvoice.tanggalTerima);
    dateInvoiceTempo = DateTime.parse(oldInvoice.jatuhTempo);
    tcDate.text = "${DateFormat.yMMMd('id').add_jm().format(dateInvoice!)} WIB";
    tcDateTempo.text =
        "${DateFormat.yMMMd('id').add_jm().format(dateInvoiceTempo!)} WIB";
  }

  void updateInvoice(String id) async {
    navigatorKey.currentContext!.pop();
    int totalHarga = 0;
    for (var data in invoicesItem) {
      totalHarga += data.jumlahHarga;
    }
    final body = {
      "id": id,
      "tanggal_terima": dateInvoice!.toIso8601String(),
      "jatuh_tempo": dateInvoiceTempo!.toIso8601String(),
      "dp": AppCurrency.rupiahToNumber(tcDP.text),
      "sisa_tagihan": AppCurrency.rupiahToNumber(tcSisaTagihan.text),
      "id_customer": selectedCustomer.value.id,
      "items": invoicesItem.map((e) => e.toJson()).toList(),
      "total_harga": totalHarga,
    };

    final response = await invoiceRepository.updateInvoice(body);
    if (response == null) {
      clearTextEditing();
      getInvoices();
    }
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      width: 350,
      behavior: SnackBarBehavior.floating,
      content: AppTextNormal.labelW600(
          response ?? "Invoice berhasil diubah", 16, Colors.white),
    ));
  }

  void deleteInvoice(String id) async {
    navigatorKey.currentContext!.pop();
    final response = await invoiceRepository.deleteInvoice(id);
    if (response == null) {
      getInvoices();
    }
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
      width: 350,
      behavior: SnackBarBehavior.floating,
      content: AppTextNormal.labelW600(
          response ?? "Invoice berhasil dihapus", 16, Colors.white),
    ));
  }
}
