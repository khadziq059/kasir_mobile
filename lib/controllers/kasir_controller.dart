import 'package:get/get.dart';
import 'package:kasir/models/Product.dart';

class KasirController extends GetxController {
  var productName = ''.obs;
  var productPrice = 0.0.obs;
  var products = <Product>[].obs;

  var totalSalesToday = 0.0.obs;
  var totalTransactions = 0.obs;

  var transactionHistory = <List<Product>>[].obs;

  void addProduct() {
    if (productName.value.isNotEmpty && productPrice.value > 0) {
      products.add(Product(
        name: productName.value,
        price: productPrice.value,
      ));
      productName.value = '';
      productPrice.value = 0.0;
    } else {
      Get.snackbar(
        'Error',
        'Nama Produk dan Harga harus diisi dan harga harus lebih besar dari 0!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  double getTotalPrice() {
    return products.fold(0.0, (sum, item) => sum + item.price);
  }

  Map<String, double> getSalesByProduct() {
    Map<String, double> sales = {};

    for (var product in products) {
      if (sales.containsKey(product.name)) {
        sales[product.name] = sales[product.name]! + product.price;
      } else {
        sales[product.name] = product.price;
      }
    }

    return sales;
  }

  double completeTransaction() {
    double total = getTotalPrice();
    transactionHistory.add(List<Product>.from(products));
    totalSalesToday.value += total;
    totalTransactions.value += 1;

    return total;
  }

  List<List<Product>> getTransactionHistory() {
    return transactionHistory;
  }
}
