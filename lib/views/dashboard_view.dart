import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:fl_chart/fl_chart.dart';
import '../controllers/kasir_controller.dart';
import '../widgets/sidebar.dart';
import '../widgets/pie_chart_sample.dart';

class DashboardView extends StatelessWidget {
  final KasirController kasirController = Get.put(KasirController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue, // Warna biru untuk app bar
      ),
      drawer: const Sidebar(),
      backgroundColor: Colors.white, // Latar belakang putih untuk halaman
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Padding untuk memberi ruang di sekitar konten
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Teks total penjualan dengan gaya elegan
                Obx(() => Text(
                      'Total Penjualan Hari Ini: Rp ${kasirController.totalSalesToday.value.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.blue, // Warna biru untuk teks utama
                            fontWeight: FontWeight.bold,
                          ),
                    )),
                const SizedBox(height: 10),
                
                // Teks jumlah transaksi dengan gaya elegan
                Obx(() => Text(
                      'Jumlah Transaksi Hari Ini: ${kasirController.totalTransactions.value}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.blue.shade700, // Warna biru lebih gelap untuk teks kedua
                          ),
                    )),
                const SizedBox(height: 20),

                Obx(() {
                  if (kasirController.totalTransactions.value > 0) {
                  return PieChartSample2();
                  } else {
                  return SizedBox.shrink();
                  }
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
