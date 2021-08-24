import 'package:polarstar_flutter/app/controller/mail/mail_controller.dart';
import 'package:polarstar_flutter/app/data/provider/mail/mail_provider.dart';

import 'package:get/get.dart';
import 'package:polarstar_flutter/app/data/repository/mail/mail_repository.dart';

class MailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
        MailController(repository: MailRepository(apiClient: MailApiClient())));
  }
}
