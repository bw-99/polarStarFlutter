import 'package:get/get.dart';
import 'package:polarstar_flutter/app/bindings/board/board_binding.dart';
import 'package:polarstar_flutter/app/bindings/board/post_binding.dart';
import 'package:polarstar_flutter/app/bindings/board/write_post_binding.dart';
import 'package:polarstar_flutter/app/bindings/login_binding.dart';
import 'package:polarstar_flutter/app/bindings/main_binding.dart';
import 'package:polarstar_flutter/app/controller/login/login_controller.dart';
import 'package:polarstar_flutter/app/ui/android/board/board.dart';
import 'package:polarstar_flutter/app/ui/android/board/post.dart';
import 'package:polarstar_flutter/app/ui/android/board/write_post.dart';
import 'package:polarstar_flutter/app/ui/android/home/home_page.dart';
import 'package:polarstar_flutter/app/ui/android/main/main_page.dart';
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
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.POST,
      page: () => Post(),
      binding: PostBinding(),
    ),
    GetPage(name: Routes.BOARD, page: () => Board(), binding: BoardBinding()),
    GetPage(
        name: Routes.WRITE_POST,
        page: () => WritePost(),
        binding: WritePostBinding())
  ];
}
