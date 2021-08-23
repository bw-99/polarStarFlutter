import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/controller/main/main_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key key,
    @required this.mainController,
  }) : super(key: key);

  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outlined),
            label: 'work',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'boards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'unity',
          ),
        ],
        unselectedItemColor: Colors.black,
        currentIndex: mainController.mainPageIndex.value,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          if (index == 1) {
            Get.toNamed("/outside/1/page/1");
          } else {
            mainController.mainPageIndex.value = index;
          }
        },
      );
    });
  }
}
