import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kasir_controller.dart';
import '../widgets/inputfield.dart';

class KasirView extends StatelessWidget {
  final KasirController kasirController = Get.put(KasirController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController productPriceController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir'),
        backgroundColor: Colors.blue, // Warna biru untuk AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white, // Latar belakang putih untuk halaman
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Field untuk Nama Produk menggunakan widget InputField
            InputField(
              controller: productNameController,
              labelText: 'Nama Produk',
              onChanged: (value) {
                // Mengatur nilai nama produk di controller
                kasirController.productName.value = value;
              },
            ),
            const SizedBox(height: 20),
            // Input Field untuk Harga Produk menggunakan widget InputField
            InputField(
              controller: productPriceController,
              labelText: 'Harga Produk',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                // Mengatur nilai harga produk di controller
                kasirController.productPrice.value =
                    double.tryParse(value) ?? 0.0;
              },
            ),
            const SizedBox(height: 20),
            // Tombol untuk Menambahkan Produk
            ElevatedButton(
              onPressed: () {
                kasirController.addProduct();
                // Reset input fields
                productNameController.clear();
                productPriceController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Sudut dibulatkan
                ),
              ),
              child: const Text(
                'Tambah',
                style: TextStyle(fontSize: 18, color: Colors.white), // Warna teks putih
              ),
            ),
            const SizedBox(height: 20),
            // Daftar Produk yang Ditambahkan
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: kasirController.products.length,
                  itemBuilder: (context, index) {
                    final product = kasirController.products[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      elevation: 5, // Menambah efek bayangan pada card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Card dengan sudut melengkung
                      ),
                      child: ListTile(
                        title: Text(
                          product.name,
                          style: TextStyle(
                            color: Colors.blue, // Nama produk dengan warna biru
                            fontWeight: FontWeight.bold, // Teks tebal
                          ),
                        ),
                        subtitle: Text(
                          'Rp ${product.price.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.blue.shade700), // Harga dengan biru gelap
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            // Menampilkan Total Harga menggunakan Obx
            Center(
              child: Obx(() {
              return Text(
                'Total Harga: Rp ${kasirController.getTotalPrice().toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue.shade700, // Warna biru gelap untuk total harga
                  fontWeight: FontWeight.bold, // Menebalkan teks
                  ),
              );
              }),
            ),
            const SizedBox(height: 20),
            // Tombol untuk Selesaikan Transaksi
            Center(
              child: ElevatedButton(
              onPressed: () {
                double total = kasirController.completeTransaction();

                // Menampilkan dialog setelah transaksi selesai
                Get.defaultDialog(
                title: 'Transaksi Selesai',
                content: Text('Total Harga: Rp ${total.toStringAsFixed(2)}'),
                textConfirm: 'OK',
                onConfirm: () {
                  Get.back();
                },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Warna biru untuk tombol
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Sudut dibulatkan
                ),
              ),
              child: const Text(
                'Selesaikan Transaksi',
                style: TextStyle(fontSize: 18, color: Colors.white), // Warna teks putih
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
