import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:polarstar_flutter/app/data/repository/board/post_repository.dart';
import 'package:polarstar_flutter/session.dart';

class WritePostController extends GetxController {
  final PostRepository repository;
  final box = GetStorage();
  final String putOrPost;
  int COMMUNITY_ID;
  int BOARD_ID;
  Rx<bool> _dataAvailable = false.obs;

  WritePostController(
      {@required this.repository,
      @required this.COMMUNITY_ID,
      this.BOARD_ID,
      @required this.putOrPost})
      : assert(repository != null);

  // Post
  RxBool anonymousCheck = true.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> postPost(Map<String, dynamic> data) async {
    String url = '/board/$COMMUNITY_ID';
    return await Session().postX(url, data);
  }

  bool get dataAvailable => _dataAvailable.value;
}
