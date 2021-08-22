import 'dart:convert';
import 'package:polarstar_flutter/app/data/model/profile/mypage_model.dart';
import 'package:polarstar_flutter/session.dart';

class MyPageApiClient {
  Future<Map<String, dynamic>> getMineWrite() async {
    var response = await Session().getX("/info");
    var responseBody = jsonDecode(response.body);
    var profileData = responseBody["PROFILE"];
    Iterable listMyPageBoard = responseBody["WritePost"];
    List<MyPageBoardModel> listMyPageBoardVal;
    MyProfileModel myProfile;

    listMyPageBoardVal = listMyPageBoard
        .map((model) => MyPageBoardModel.fromJson(model))
        .toList();
    myProfile = MyProfileModel.fromJson(profileData);

    return {
      "status": response.statusCode,
      "myPageBoard": listMyPageBoardVal,
      "myProfile": myProfile
    };
  }

  Future<Map<String, dynamic>> getMineLike() async {
    var response = await Session().getX("/info/like");
    var responseBody = jsonDecode(response.body);
    List<MyPageBoardModel> listMyPageBoardVal;
    Iterable listMyPageBoard = responseBody["LIKE"];
    listMyPageBoardVal = listMyPageBoard
        .map((model) => MyPageBoardModel.fromJson(model))
        .toList();
    return {"status": response.statusCode, "myPageBoard": listMyPageBoardVal};
  }

  Future<Map<String, dynamic>> getMineScrap() async {
    var response = await Session().getX("/info/scrap");
    var responseBody = jsonDecode(response.body);
    List<MyPageBoardModel> listMyPageBoardVal;
    Iterable listMyPageBoard = responseBody["SCRAP"];
    listMyPageBoardVal = listMyPageBoard
        .map((model) => MyPageBoardModel.fromJson(model))
        .toList();
    return {"status": response.statusCode, "myPageBoard": listMyPageBoardVal};
  }
}
