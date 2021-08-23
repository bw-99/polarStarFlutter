import 'package:meta/meta.dart';
import 'package:polarstar_flutter/app/data/provider/board/board_provider.dart';

class BoardRepository {
  final BoardApiClient apiClient;

  BoardRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<Map<String, dynamic>> getBoard(int COMMUNITY_ID, int page) async {
    final json = await apiClient.getBoard(COMMUNITY_ID, page);
    return json;
  }

  Future<Map<String, dynamic>> getHotBoard(int page) async {
    final json = await apiClient.getHotBoard(page);
    return json;
  }

  Future<Map<String, dynamic>> getSearchBoard(
      String searchText, int COMMUNITY_ID) async {
    //커뮤 아이디가 -1이면 핫게임
    final json = COMMUNITY_ID == -1
        ? await apiClient.getSearchHotBoard(searchText)
        : await apiClient.getSearchBoard(searchText, COMMUNITY_ID);
    return json;
  }

  Future<Map<String, dynamic>> getSearchAll(String searchText) async {
    //커뮤 아이디가 -1이면 핫게임
    final json = await apiClient.getSearchAll(searchText);
    return json;
  }
}
