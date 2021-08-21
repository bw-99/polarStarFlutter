import 'package:polarstar_flutter/app/controller/board/board_controller.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/data/provider/board/board_provider.dart';
import 'package:polarstar_flutter/app/data/repository/board/board_repository.dart';

class BoardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BoardController(
        repository: BoardRepository(apiClient: BoardApiClient()),
        initCommunityId: int.parse(Get.parameters["COMMUNITY_ID"]),
        initPage: int.parse(Get.parameters["page"])));
  }
}
