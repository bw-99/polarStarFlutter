import 'package:polarstar_flutter/app/controller/board/post_controller.dart';
import 'package:polarstar_flutter/app/controller/login/login_controller.dart';
import 'package:polarstar_flutter/app/controller/main/main_controller.dart';
import 'package:polarstar_flutter/app/data/provider/api.dart';
import 'package:polarstar_flutter/app/data/provider/board/post_provider.dart';
import 'package:polarstar_flutter/app/data/provider/login_provider.dart';
import 'package:polarstar_flutter/app/data/provider/main_provider.dart';
import 'package:polarstar_flutter/app/data/repository/board/post_repository.dart';
import 'package:polarstar_flutter/app/data/repository/login_repository.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/data/repository/main_repository.dart';

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
