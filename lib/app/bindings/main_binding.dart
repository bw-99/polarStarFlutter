import 'package:polarstar_flutter/app/controller/main/main_controller.dart';

import 'package:polarstar_flutter/app/data/provider/main_provider.dart';

import 'package:get/get.dart';
import 'package:polarstar_flutter/app/data/repository/main_repository.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
        MainController(repository: MainRepository(apiClient: MainApiClient())));
  }
}
