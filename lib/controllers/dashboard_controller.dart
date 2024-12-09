import 'package:get/get.dart';

class DashboardController extends GetxController {
  var userName = 'H1D022059'.obs;
  var totalPenjualan = 0.0.obs;
  var jumlahTransaksi = 0.obs;

  void logout() {
    userName.value = '';
    Get.offAllNamed('/login');
  }

}
