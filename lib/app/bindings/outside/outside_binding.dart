import 'package:polarstar_flutter/app/controller/board/board_controller.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/controller/outside/outside_controller.dart';
import 'package:polarstar_flutter/app/data/provider/board/board_provider.dart';
import 'package:polarstar_flutter/app/data/repository/board/board_repository.dart';

class OutSideBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put(OutSideController(
        repository: BoardRepository(apiClient: BoardApiClient()),
        initCommunityId: int.parse(Get.parameters["COMMUNITY_ID"]),
        initPage: int.parse(Get.parameters["page"])));

    final OutSideController outSideController = Get.find();

    await outSideController.getBoard();
  }
}
