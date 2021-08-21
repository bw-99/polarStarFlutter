import 'package:polarstar_flutter/app/controller/board/board_controller.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/controller/board/write_post_controller.dart';
import 'package:polarstar_flutter/app/data/provider/board/board_provider.dart';
import 'package:polarstar_flutter/app/data/provider/board/post_provider.dart';
import 'package:polarstar_flutter/app/data/repository/board/board_repository.dart';
import 'package:polarstar_flutter/app/data/repository/board/post_repository.dart';

class WritePostBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(WritePostController(
        repository: PostRepository(apiClient: PostApiClient()),
        COMMUNITY_ID: int.parse(Get.parameters["COMMUNITY_ID"]),
        putOrPost: Get.parameters["BOARD_ID"] != null ? "put" : "post",
        BOARD_ID: Get.parameters["BOARD_ID"] != null
            ? int.parse(Get.parameters["BOARD_ID"])
            : null));
  }
}
