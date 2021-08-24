import 'package:polarstar_flutter/app/controller/board/board_controller.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/controller/outside/outside_controller.dart';
import 'package:polarstar_flutter/app/controller/search/search_controller.dart';
import 'package:polarstar_flutter/app/data/provider/board/board_provider.dart';
import 'package:polarstar_flutter/app/data/provider/outside/outside_provider.dart';
import 'package:polarstar_flutter/app/data/provider/search/search_provider.dart';
import 'package:polarstar_flutter/app/data/repository/board/board_repository.dart';
import 'package:polarstar_flutter/app/data/repository/outside/outside_repository.dart';
import 'package:polarstar_flutter/app/data/repository/search/search_repository.dart';

class OutSideBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put(OutSideController(
        repository: OutSideRepository(apiClient: OutSideApiClient()),
        initCommunityId: int.parse(Get.parameters["COMMUNITY_ID"]),
        initPage: int.parse(Get.parameters["page"])));

    Get.put(
      SearchController(
          repository: SearchRepository(apiClient: SearchApiClient()),
          initCommunityId: int.parse(Get.parameters["COMMUNITY_ID"]),
          initPage: int.parse(Get.parameters["page"]),
          from: "outside"),
    );

    final OutSideController outSideController = Get.find();

    await outSideController.getBoard();
    //취업 정보 긁어왔음 true
    outSideController.didFetchInfo[0] = true;
    //긁어온걸 postBody에 넣어줌
    outSideController.postBodtOutside[outSideController.COMMUNITY_ID.value - 1]
        .forEach((element) {
      outSideController.postBody.add(element);
    });
  }
}
