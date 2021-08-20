import 'package:get/get.dart';
import 'package:polarstar_flutter/app/bindings/login_binding.dart';
import 'package:polarstar_flutter/app/controller/login/login_controller.dart';
import 'package:polarstar_flutter/app/ui/android/home/home_page.dart';
import 'package:polarstar_flutter/app/ui/android/login/login_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.MAIN_PAGE,
      page: () => HomePage(),
    )
  ];
}
