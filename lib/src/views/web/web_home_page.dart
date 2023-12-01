import 'package:anjastore/src/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_constanta.dart';
import '../../../utils/app_text_normal.dart';

class WebHomePage extends StatelessWidget {
  WebHomePage({super.key});

  final _hC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextNormal.labelBold(
              "Report",
              26,
              colorPrimaryDark,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppTextNormal.labelW600(
                                      "Pemasukan Lunas",
                                      24,
                                      Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          // Expanded(
                          //   flex: 2,
                          //   child: BlocBuilder<HomeBloc, HomeState>(
                          //     builder: (context, state) {
                          //       int total = 0;

                          //       for (var data in state.invoices) {
                          //         if (data.sisaTagihan == 0) {
                          //           total += data.totalHarga;
                          //         } else {
                          //           total += data.dp;
                          //         }
                          //       }
                          //       return Align(
                          //         alignment: Alignment.centerRight,
                          //         child: AppTextNormal.labelBold(
                          //           currencyFormatter.format(total),
                          //           26,
                          //           Colors.green,
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: colorPrimaryDark,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppTextNormal.labelW600(
                                      "Pemasukan Belum Lunas",
                                      20,
                                      Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          // Expanded(
                          //   flex: 2,
                          //   child: BlocBuilder<HomeBloc, HomeState>(
                          //     builder: (context, state) {
                          //       final total = state.invoices.fold(
                          //           0,
                          //           (previousValue, report) =>
                          //               (previousValue + report.sisaTagihan)
                          //                   .toInt());
                          //       return Align(
                          //         alignment: Alignment.centerRight,
                          //         child: AppTextNormal.labelBold(
                          //           currencyFormatter.format(total),
                          //           26,
                          //           colorPrimaryDark,
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppTextNormal.labelW600(
                                      "Total Pemesanan",
                                      20,
                                      Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          // Expanded(
                          //   flex: 2,
                          //   child: BlocBuilder<HomeBloc, HomeState>(
                          //     builder: (context, state) {
                          //       final total = state.invoices.length;
                          //       return Align(
                          //         alignment: Alignment.centerRight,
                          //         child: AppTextNormal.labelBold(
                          //           "$total Order",
                          //           26,
                          //           Colors.grey,
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppTextNormal.labelW600(
                                      "Pengeluaran",
                                      20,
                                      Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          // Expanded(
                          //   flex: 2,
                          //   child: BlocBuilder<HomeBloc, HomeState>(
                          //     builder: (context, state) {
                          //       final total = state.pengeluarans.fold(
                          //           0,
                          //           (previousValue, report) =>
                          //               (previousValue + report.nominal)
                          //                   .toInt());
                          //       return Align(
                          //         alignment: Alignment.centerRight,
                          //         child: AppTextNormal.labelBold(
                          //           currencyFormatter.format(total),
                          //           26,
                          //           Colors.red,
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextNormal.labelBold(
                            "Overview",
                            26,
                            colorPrimaryDark,
                          ),
                          // Container(
                          //   height: 40,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(9),
                          //     color: Colors.grey.shade200,
                          //   ),
                          //   child: DropdownSearch<InvoiceEntity>(
                          //     selectedItem: invoiceDropdownEmpty,
                          //     popupProps: PopupProps.dialog(
                          //       showSearchBox: true,
                          //       searchFieldProps: TextFieldProps(
                          //         decoration: InputDecoration(
                          //           hintText: "Masukkan nama produk",
                          //           hintStyle: GoogleFonts.poppins(
                          //             fontSize: 14,
                          //             wordSpacing: 4,
                          //           ),
                          //           contentPadding: const EdgeInsets.symmetric(
                          //               vertical: 0, horizontal: 12),
                          //           border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(8),
                          //           ),
                          //           enabledBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.grey.shade300),
                          //             borderRadius: BorderRadius.circular(8),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     asyncItems: (String filter) => homeBloc
                          //         .apiServices
                          //         .getAllInvoiceForDropdown(),
                          //     itemAsString: (InvoiceEntity u) =>
                          //         DateFormat('yyyy')
                          //             .format(DateTime.parse(u.tanggalTerima)),
                          //     onChanged: (val) => homeBloc.add(
                          //         HomeSelectedYearEvent(val?.tanggalTerima ??
                          //             DateTime.now().toIso8601String())),
                          //     dropdownDecoratorProps: DropDownDecoratorProps(
                          //       dropdownSearchDecoration: InputDecoration(
                          //         hintStyle: GoogleFonts.poppins(
                          //           fontSize: 14,
                          //           wordSpacing: 4,
                          //         ),
                          //         contentPadding: const EdgeInsets.symmetric(
                          //             vertical: 0, horizontal: 12),
                          //         border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         enabledBorder: OutlineInputBorder(
                          //           borderSide:
                          //               BorderSide(color: Colors.grey.shade300),
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      // BlocBuilder<HomeBloc, HomeState>(
                      //   builder: (context, state) {
                      //     if (state.omzets.isEmpty) {
                      //       return const SizedBox();
                      //     }
                      //     return Container(
                      //       padding: const EdgeInsets.symmetric(vertical: 40),
                      //       height: 500,
                      //       color: Colors.white,
                      //       child: BarChart(
                      //         swapAnimationDuration:
                      //             const Duration(milliseconds: 600),
                      //         BarChartData(
                      //           barTouchData: BarTouchData(
                      //               touchTooltipData: BarTouchTooltipData(
                      //             tooltipBgColor: Colors.grey.shade300,
                      //             getTooltipItem:
                      //                 (group, groupIndex, rod, rodIndex) =>
                      //                     BarTooltipItem(
                      //               currencyFormatter.format(rod.toY),
                      //               GoogleFonts.montserrat(
                      //                 color: Colors.grey.shade600,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //           )),
                      //           maxY: (state.omzets
                      //                   .where((e) =>
                      //                       e.year ==
                      //                       DateTime.parse(state.selectedYear)
                      //                           .year)
                      //                   .toList()
                      //                   .map((data) => data.count)
                      //                   .reduce((max, value) =>
                      //                       value > max ? value : max) +
                      //               20),
                      //           minY: 0,
                      //           gridData: FlGridData(show: true),
                      //           borderData: FlBorderData(
                      //             show: true,
                      //             border: const Border(
                      //               bottom: BorderSide(
                      //                 color: Colors.grey,
                      //               ),
                      //               left: BorderSide(
                      //                 color: Colors.grey,
                      //               ),
                      //             ),
                      //           ),
                      //           titlesData: FlTitlesData(
                      //             show: true,
                      //             topTitles: AxisTitles(
                      //               sideTitles: SideTitles(
                      //                 showTitles: false,
                      //               ),
                      //             ),
                      //             rightTitles: AxisTitles(
                      //               sideTitles: SideTitles(
                      //                 showTitles: false,
                      //               ),
                      //             ),
                      //             bottomTitles: AxisTitles(
                      //               sideTitles: SideTitles(
                      //                 showTitles: true,
                      //                 getTitlesWidget: homeBloc.getBottomTitles,
                      //               ),
                      //             ),
                      //           ),
                      //           barGroups: state.omzets
                      //               .where((e) =>
                      //                   e.year ==
                      //                   DateTime.parse(state.selectedYear).year)
                      //               .toList()
                      //               .map((data) {
                      //             return BarChartGroupData(
                      //               x: data.month,
                      //               barRods: [
                      //                 BarChartRodData(
                      //                   toY: data.count,
                      //                   color: Colors.blue,
                      //                   width: 25,
                      //                   borderRadius: BorderRadius.circular(0),
                      //                 ),
                      //               ],
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 14),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextNormal.labelBold(
                          "Most Popular Order",
                          26,
                          colorPrimaryDark,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        // BlocBuilder<HomeBloc, HomeState>(
                        //   builder: (context, state) {
                        //     return Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: List.generate(
                        //         state.userOrders.length,
                        //         (index) => ListTile(
                        //           contentPadding: EdgeInsets.zero,
                        //           leading: Container(
                        //             width: 45,
                        //             height: 45,
                        //             decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               color: Colors.grey.shade300,
                        //             ),
                        //             child: const Center(
                        //               child: Icon(
                        //                 Icons.person_rounded,
                        //               ),
                        //             ),
                        //           ),
                        //           title: AppTextNormal.labelBold(
                        //             state.userOrders[index].namaCustomer
                        //                 .toUpperCase(),
                        //             14,
                        //             Colors.black,
                        //           ),
                        //           subtitle: AppTextNormal.labelBold(
                        //             "${state.userOrders[index].jumlahOrder} Order",
                        //             12.5,
                        //             Colors.grey.shade400,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
