import 'package:polarstar_flutter/app/controller/board/post_controller.dart';

import 'package:polarstar_flutter/app/data/provider/board/post_provider.dart';

import 'package:polarstar_flutter/app/data/repository/board/post_repository.dart';

import 'package:get/get.dart';

class PostBinding implements Bindings {
  @override
  void dependencies() {
    print(Get.parameters["COMMUNITY_ID"]);
    Get.put(PostController(
        COMMUNITY_ID: int.parse(Get.parameters["COMMUNITY_ID"]),
        BOARD_ID: int.parse(Get.parameters["BOARD_ID"]),
        repository: PostRepository(apiClient: PostApiClient())));
  }
}
