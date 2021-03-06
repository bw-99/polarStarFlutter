import 'package:meta/meta.dart';
import 'package:polarstar_flutter/app/data/model/main_model.dart';
import 'package:polarstar_flutter/app/data/provider/login_provider.dart';
import 'package:polarstar_flutter/app/data/provider/main_provider.dart';
import 'package:polarstar_flutter/app/ui/android/functions/crypt.dart';

class MainRepository {
  final MainApiClient apiClient;

  MainRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<Map<String, List<dynamic>>> getBoardInfo() async {
    var MapBoardInfo = await apiClient.getBoardInfo();

    return MapBoardInfo;
  }
}
