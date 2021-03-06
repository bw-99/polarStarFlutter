import 'package:flutter/material.dart';
import 'package:polarstar_flutter/app/ui/android/functions/form_validator.dart';
import 'package:polarstar_flutter/app/ui/android/functions/crypt.dart';
import 'package:polarstar_flutter/app/controller/login/login_controller.dart';
import 'dart:convert';
import 'package:polarstar_flutter/session.dart';
// import 'crypt.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polarstar_flutter/app/ui/android/widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('polarStar'),
      ),
      body: LoginInputs(),
    );
  }
}

class LoginInputs extends StatelessWidget {
  LoginInputs({Key key}) : super(key: key);

  final loginIdContoller = TextEditingController();
  final loginPwContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final box = GetStorage();

  final LoginController loginController = Get.find();

  // login 함수

  @override
  Widget build(BuildContext context) {
    // final notiController = Get.put(NotiController());
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          CustomTextFormField(
            hint: "ID",
            textController: loginIdContoller,
            funcValidator: (value) {
              return checkEmpty(value);
            },
          ),
          CustomTextFormField(
            hint: "PASSWORD",
            textController: loginPwContoller,
            funcValidator: (value) {
              return checkEmpty(value);
            },
          ),
          Row(children: [
            Obx(
              () => Checkbox(
                  value: loginController.isAutoLogin.value,
                  onChanged: (value) {
                    loginController.updateAutoLogin(value);
                  }),
            ),
            Text('자동 로그인')
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    print(_formKey.currentState.validate());
                    if (_formKey.currentState.validate()) {
                      await loginController.login(loginIdContoller.text,
                          loginIdContoller.text, "1123123123");
                      // await userLogin(notiController.tokenFCM.value);
                    }
                  },
                  child: Text("로그인")),
              ElevatedButton(
                  onPressed: () => Get.toNamed('/signUp'), child: Text("회원가입"))
            ],
          )
        ],
      ),
    );
  }
}
