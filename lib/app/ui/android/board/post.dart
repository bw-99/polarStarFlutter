// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/controller/board/post_controller.dart';
import 'package:polarstar_flutter/app/ui/android/board/widgets/bottom_keyboard.dart';
import 'package:polarstar_flutter/app/ui/android/board/widgets/post_layout.dart';

class Post extends StatelessWidget {
  final mailWriteController = TextEditingController();
  // final mailController = Get.put(MailController());
  final BOTTOM_SHEET_HEIGHT = 60;
  final PostController c = Get.find();
  final commentWriteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('polarStar'),
        ),
        body: Obx(() {
          if (!c.dataAvailable) {
            return CircularProgressIndicator();
          } else {
            return PostLayout(
              c: c,
            );
          }
        }),
        bottomSheet: BottomKeyboard(
            BOTTOM_SHEET_HEIGHT: BOTTOM_SHEET_HEIGHT,
            c: c,
            commentWriteController: commentWriteController));
  }
}
