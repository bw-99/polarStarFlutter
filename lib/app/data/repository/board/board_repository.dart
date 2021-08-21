import 'package:meta/meta.dart';
import 'package:polarstar_flutter/app/data/provider/board/board_provider.dart';
import 'package:polarstar_flutter/app/data/provider/board/post_provider.dart';

class BoardRepository {
  final BoardApiClient apiClient;

  BoardRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<Map<String, dynamic>> getBoard(int COMMUNITY_ID, int page) async {
    final json = await apiClient.getBoard(COMMUNITY_ID, page);
    return json;
  }
}
