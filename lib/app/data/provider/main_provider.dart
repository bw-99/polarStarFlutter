import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polarstar_flutter/app/data/model/main_model.dart';
import 'package:polarstar_flutter/app/data/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:polarstar_flutter/session.dart';

class MainApiClient {
  Future<Map<String, List<dynamic>>> getBoardInfo() async {
    var getResponse = await Session().getX('/');
    final jsonResponse = jsonDecode(getResponse.body);

    Iterable boardInfo = jsonResponse["board"];
    Iterable hotBoard = jsonResponse["HotBoard"];

    List<BoardInfo> listBoardInfo =
        boardInfo.map((model) => BoardInfo.fromJson(model)).toList();

    List<HotBoard> listHotBoard =
        hotBoard.map((model) => HotBoard.fromJson(model)).toList();

    return {"boardInfo": listBoardInfo, "hotBoard": listHotBoard};
  }
}


// getAll() async {
//     try {
//       var response = await Session().get(baseUrl);
//       if (response.statusCode == 200) {
//         Iterable jsonResponse = json.decode(response.body);
//         List<MyModel> listMyModel =
//             jsonResponse.map((model) => MyModel.fromJson(model)).toList();
//         return listMyModel;
//       } else
//         print('erro');
//     } catch (_) {}
//   }

//   getId(id) async {
//     try {
//       var response = await Session().get(baseUrl);
//       if (response.statusCode == 200) {
//         //Map<String, dynamic> jsonResponse = json.decode(response.body);
//       } else
//         print('erro -get');
//     } catch (_) {}
//   }