part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const LOGIN = '/login';
  static const MAIN_PAGE = '/main';
  static const POST = "/board/:COMMUNITY_ID/read/:BOARD_ID";
  static const BOARD = "/board/:COMMUNITY_ID/page/:page";
  static const WRITE_POST = "/board/:COMMUNITY_ID";
  static const WRITE_PUT = "/board/:COMMUNITY_ID/bid/:BOARD_ID";
  static const MYPAGE = "/myPage";
  static const MYPROFILE = "/myPage/profile";
  static const DETAILS = '/details';
}
