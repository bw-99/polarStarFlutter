import 'dart:convert';
import 'package:polarstar_flutter/app/data/model/board/board_model.dart';

import 'package:polarstar_flutter/session.dart';

class BoardApiClient {
  Future<Map<String, dynamic>> getBoard(int COMMUNITY_ID, int page) async {
    var response = await Session().getX("/board/$COMMUNITY_ID/page/$page");
    Iterable jsonResponse = jsonDecode(response.body);

    List<Board> listBoard =
        jsonResponse.map((model) => Board.fromJson(model)).toList();

    return {"status": response.statusCode, "listBoard": listBoard};
  }

  Future<Map<String, dynamic>> getHotBoard(int page) async {
    var response = await Session().getX("/board/hot/page/$page");
    Iterable jsonResponse = jsonDecode(response.body);

    List<Board> listBoard =
        jsonResponse.map((model) => Board.fromJson(model)).toList();

    return {"status": response.statusCode, "listBoard": listBoard};
  }

  Future<Map<String, dynamic>> getSearchAll(String searchText) async {
    var response =
        await Session().getX("/board/searchAll/page/1?search=$searchText");
    Iterable jsonResponse = jsonDecode(response.body);

    List<Board> listBoard =
        jsonResponse.map((model) => Board.fromJson(model)).toList();

    return {"status": response.statusCode, "listBoard": listBoard};
  }

  Future<Map<String, dynamic>> getSearchBoard(
      String searchText, int COMMUNITY_ID) async {
    var response = await Session()
        .getX("/board/$COMMUNITY_ID/search/page/1?search=$searchText");
    Iterable jsonResponse = jsonDecode(response.body);

    List<Board> listBoard =
        jsonResponse.map((model) => Board.fromJson(model)).toList();

    return {"status": response.statusCode, "listBoard": listBoard};
  }

  //핫게 검색 기능 서버에서 구현해야함
  Future<Map<String, dynamic>> getSearchHotBoard(String searchText) async {
    var response =
        await Session().getX("/board/hot/search/page/1?search=$searchText");
    Iterable jsonResponse = jsonDecode(response.body);

    List<Board> listBoard =
        jsonResponse.map((model) => Board.fromJson(model)).toList();

    return {"status": response.statusCode, "listBoard": listBoard};
  }
}
