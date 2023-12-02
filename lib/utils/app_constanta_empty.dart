import 'package:anjastore/src/models/model.dart';

const userEmpty = UserM(
  email: "",
  id: "",
  role: 99,
  name: "",
  page: 0,
  created: "",
  updated: "",
);

const customerEmpty = CustomerM(
  address: "",
  email: "",
  id: "",
  hp: "",
  name: "",
  page: 0,
);

const productEmpty = ProductM(
  name: "",
  code: "",
  id: "",
  created: "",
  updated: "",
  page: 0,
);

const invoiceEmpty = InvoiceM(
  dp: 0,
  id: "",
  idCustomer: "",
  no: 0,
  noInvoice: "",
  sisaTagihan: 0,
  jatuhTempo: "",
  tanggalTerima: "",
  totalHarga: 0,
  items: [],
  page: 0,
  kodeInvoice: "",
);
