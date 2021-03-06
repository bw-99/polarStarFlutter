import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:polarstar_flutter/app/controller/outside/outside_controller.dart';
import 'package:polarstar_flutter/app/controller/search/search_controller.dart';
import 'package:polarstar_flutter/app/ui/android/outside/widgets/outside_layout.dart';
import 'package:polarstar_flutter/app/ui/android/search/widgets/search_bar.dart';
import 'package:polarstar_flutter/app/ui/android/widgets/app_bar.dart';

class OutSide extends StatelessWidget {
  OutSide({Key key}) : super(key: key);
  final OutSideController controller = Get.find();
  final SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
              pageName: "OUTSIDE",
            ),
            body: RefreshIndicator(
              onRefresh: controller.refreshPage,
              child: Stack(
                children: [
                  ListView(),
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: Get.mediaQuery.size.width,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.COMMUNITY_ID.value = 1;
                                  //정보 검색 컨트롤러 값도 변경
                                  searchController.COMMUNITY_ID.value = 1;
                                },
                                child: Text("취업")),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.COMMUNITY_ID.value = 2;
                                  //정보 검색 컨트롤러 값도 변경
                                  searchController.COMMUNITY_ID.value = 2;
                                },
                                child: Text("알바")),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.COMMUNITY_ID.value = 3;
                                  //정보 검색 컨트롤러 값도 변경
                                  searchController.COMMUNITY_ID.value = 3;
                                },
                                child: Text("공모전")),
                          )
                        ],
                      ),
                      // 게시글 프리뷰 리스트
                      Expanded(
                        child: Obx(() {
                          if (controller.dataAvailablePostPreview.value) {
                            return ListView.builder(
                                controller: controller.scrollController.value,
                                itemCount: controller.postBody.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return OutSidePostPreview(
                                    item: controller.postBody[index],
                                  );
                                });
                          } else if (controller.httpStatus != 200) {
                            return Text("아직 게시글이 없습니다.");
                          } else {
                            return Text("아직 게시글이 없습니다.");
                          }
                        }),
                      ),
                    ],
                  ),
                  SearchBar(
                    controller: searchController,
                  ),
                ],
              ),
            )));
  }
}
