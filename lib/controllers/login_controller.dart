import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLogged = true.obs;

  void login(String username, String password) {
    if (username == 'H1D022059' && password  == 'khadziq265') {
      isLogged.value = true;
      Get.offAllNamed('/dashboard');
    }else if (username.isEmpty) {
      isLogged.value = false;
      Get.snackbar('Error', 'Username tidak boleh kosong');
    }
    else if (password.isEmpty) {
      isLogged.value = false;
      Get.snackbar('Error', 'Password tidak boleh kosong');
    }
    else {
      Get.snackbar('Error', 'Username atau password salah');
    }
  }
}