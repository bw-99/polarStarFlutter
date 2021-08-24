import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polarstar_flutter/app/data/model/login_model.dart';
import 'package:meta/meta.dart';
import 'package:polarstar_flutter/app/data/model/main_model.dart';
import 'package:polarstar_flutter/app/data/repository/main_repository.dart';
import 'package:polarstar_flutter/session.dart';

class MainController extends GetxController {
  final MainRepository repository;
  final box = GetStorage();

  MainController({@required this.repository}) : assert(repository != null);

  RxList<BoardInfo> boardInfo = <BoardInfo>[].obs;
  RxList<HotBoard> hotBoard = <HotBoard>[].obs;
  RxBool _dataAvailable = false.obs;
  RxInt mainPageIndex = 0.obs;

  Future<void> getBoardInfo() async {
    final value = await repository.getBoardInfo();
    boardInfo.value = value["boardInfo"];
    hotBoard.value = value["hotBoard"];
    List<BoardInfo> totalBoardInfo = [];

    for (BoardInfo item in value["boardInfo"]) {
      totalBoardInfo.add(item);
    }

    totalBoardInfo.addAll([
      BoardInfo.fromJson({"COMMUNITY_ID": 1, "COMMUNITY_NAME": "취업"}),
      BoardInfo.fromJson({"COMMUNITY_ID": 2, "COMMUNITY_NAME": "알바"}),
      BoardInfo.fromJson({"COMMUNITY_ID": 3, "COMMUNITY_NAME": "공모전"}),
    ]);

    box.write("boardInfo", totalBoardInfo);

    print(hotBoard);
    print(boardInfo);
    _dataAvailable.value = true;
  }

  @override
  onInit() async {
    super.onInit();
    await getBoardInfo();
  }

  @override
  onClose() async {
    super.onClose();
    _dataAvailable.value = false;
  }

  bool get dataAvailalbe => _dataAvailable.value;
}
