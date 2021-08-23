import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polarstar_flutter/app/controller/main/main_controller.dart';
import 'package:polarstar_flutter/app/ui/android/main/widgets/board_list.dart';
import 'package:polarstar_flutter/app/ui/android/main/widgets/main_page_scroll.dart';
import 'package:polarstar_flutter/app/ui/android/widgets/app_bar.dart';
import 'package:polarstar_flutter/app/ui/android/widgets/bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  final box = GetStorage();
  List<Widget> mainPageWidget = [
    MainPageScroll(),
    MainPageScroll(),
    BoardList(),
    BoardList(),
  ];

  final MainController mainController = Get.find();
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar:
            CustomBottomNavigationBar(mainController: mainController),
        body: Obx(() => mainPageWidget[mainController.mainPageIndex.value]),
      ),
    );
  }
}
