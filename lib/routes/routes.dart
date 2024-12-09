import 'package:get/get.dart';

import '../views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/kasir_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => LoginView()), // Rute untuk halaman login
    GetPage(name: '/dashboard', page: () => DashboardView()), // Rute untuk halaman home
    GetPage(name: '/kasir', page: () => KasirView()), // Rute untuk halaman kasir
  ];
}
