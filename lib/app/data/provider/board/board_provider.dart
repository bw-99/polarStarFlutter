import 'dart:convert';
import 'package:polarstar_flutter/app/data/model/board/board_model.dart';
import 'package:polarstar_flutter/app/data/model/board/post_model.dart';
import 'package:polarstar_flutter/session.dart';

class BoardApiClient {
  Future<Map<String, dynamic>> getBoard(int COMMUNITY_ID, int page) async {
    var response = await Session().getX("/board/$COMMUNITY_ID/page/$page");
    Iterable jsonResponse = jsonDecode(response.body);

    List<Board> listBoard =
        jsonResponse.map((model) => Board.fromJson(model)).toList();

    return {"status": response.statusCode, "listBoard": listBoard};
  }
}
