import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/controller/board/board_controller.dart';
import 'package:polarstar_flutter/app/ui/android/board/widgets/board_layout.dart';
import 'package:polarstar_flutter/app/ui/android/widgets/app_bar.dart';

class Board extends StatelessWidget {
  Board({Key key}) : super(key: key);
  final BoardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: WritePostAppBar(
              COMMUNITY_ID: int.parse(Get.parameters["COMMUNITY_ID"]),
            ),
            body: RefreshIndicator(
              onRefresh: controller.refreshPage,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: Get.mediaQuery.size.width,
                      ),
                      // 게시글 프리뷰 리스트
                      Expanded(
                        child: Obx(() {
                          if (controller.dataAvailablePostPreview.value) {
                            return ListView.builder(
                                controller: controller.scrollController.value,
                                itemCount: controller.postBody.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PostPreview(
                                    item: controller.postBody[index],
                                  );
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                      ),
                    ],
                  ),
                  SearchBar(
                    controller: controller,
                  ),
                ],
              ),
            )));
  }
}
