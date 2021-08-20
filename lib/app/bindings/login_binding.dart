import 'package:polarstar_flutter/app/controller/login/login_controller.dart';
import 'package:polarstar_flutter/app/data/provider/api.dart';
import 'package:polarstar_flutter/app/data/provider/login_provider.dart';
import 'package:polarstar_flutter/app/data/repository/login_repository.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(
        repository: LoginRepository(apiClient: LoginApiClient())));
  }
}
