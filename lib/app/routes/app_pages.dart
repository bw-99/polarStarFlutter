import 'package:get/get.dart';
import 'package:polarstar_flutter/app/bindings/board/board_binding.dart';
import 'package:polarstar_flutter/app/bindings/board/hot_board_binding.dart';
import 'package:polarstar_flutter/app/bindings/board/post_binding.dart';
import 'package:polarstar_flutter/app/bindings/board/search_binding.dart';
import 'package:polarstar_flutter/app/bindings/board/write_post_binding.dart';
import 'package:polarstar_flutter/app/bindings/login_binding.dart';
import 'package:polarstar_flutter/app/bindings/mail/mailBox_binding.dart';
import 'package:polarstar_flutter/app/bindings/mail/mailHistory_binding.dart';
import 'package:polarstar_flutter/app/bindings/main_binding.dart';
import 'package:polarstar_flutter/app/bindings/outside/outside_binding.dart';
import 'package:polarstar_flutter/app/bindings/outside/post_binding.dart';
import 'package:polarstar_flutter/app/bindings/profile/mypage_binding.dart';
import 'package:polarstar_flutter/app/ui/android/board/board.dart';
import 'package:polarstar_flutter/app/ui/android/board/hot_board.dart';
import 'package:polarstar_flutter/app/ui/android/board/post.dart';
import 'package:polarstar_flutter/app/ui/android/board/write_post.dart';
import 'package:polarstar_flutter/app/ui/android/mail/mailBox.dart';
import 'package:polarstar_flutter/app/ui/android/mail/mailHistory.dart';
import 'package:polarstar_flutter/app/ui/android/main/main_page.dart';
import 'package:polarstar_flutter/app/ui/android/login/login_page.dart';
import 'package:polarstar_flutter/app/ui/android/outside/outside_board.dart';
import 'package:polarstar_flutter/app/ui/android/outside/outside_post.dart';
import 'package:polarstar_flutter/app/ui/android/profile/mypage.dart';
import 'package:polarstar_flutter/app/ui/android/profile/profile.dart';
import 'package:polarstar_flutter/app/ui/android/search/search_board.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => MainPage(),
      binding: MainBinding(),
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
    GetPage(
      name: Routes.SEARCH_ALL,
      page: () => Board(),
      binding: BoardSearchBinding(),
    ),
    GetPage(
      name: Routes.HOTBOARD,
      page: () => HotBoard(),
      binding: HotBoardBinding(),
    ),
    GetPage(
      name: Routes.BOARD,
      page: () => Board(),
      binding: BoardBinding(),
    ),
    GetPage(
      name: Routes.WRITE_POST,
      page: () => WritePost(),
      binding: WritePostBinding(),
    ),
    GetPage(
      name: Routes.WRITE_PUT,
      page: () => WritePost(),
      binding: WritePostBinding(),
    ),
    GetPage(
      name: Routes.MYPROFILE,
      page: () => Profile(),
    ),
    GetPage(
      name: Routes.MYPAGE,
      page: () => Mypage(),
      binding: MyPageBinding(),
    ),
    GetPage(
      name: Routes.OUTSIDE,
      page: () => OutSide(),
      binding: OutSideBinding(),
    ),
    GetPage(name: Routes.SEARCH, page: () => Search()),
    GetPage(
        name: Routes.OUTSIDE_POST,
        page: () => OutSidePost(),
        binding: OutSidePostBinding()),
    GetPage(
        name: Routes.MAILHISTORY,
        page: () => MailHistory(),
        binding: MailHistoryBinding()),
    GetPage(
      name: Routes.MAILBOX,
      page: () => MailBox(),
      binding: MailBoxBinding(),
    )
  ];
}
