import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/bindings/home_binding.dart';
import 'package:polarstar_flutter/app/bindings/login_binding.dart';
import 'package:polarstar_flutter/app/routes/app_pages.dart';
// import 'package:polarstar_flutter/app/translations/app_translations.dart';

import 'app/ui/android/home/home_page.dart';
import 'app/ui/android/login/login_page.dart';
// import 'app/ui/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';
import 'session.dart';

void main() async {
  await GetStorage.init();
  if (GetStorage().hasData('token')) {
    Session.headers['Cookie'] = await GetStorage().read('token');
  }

  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: LoginBinding(),
    initialRoute: Routes.INITIAL,
    // theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    home: LoginPage(),
    locale: Locale('pt', 'BR'),
    // translationsKeys: AppTranslation.translations,
  ));
}
