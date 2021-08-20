import 'package:get/get.dart';
import 'package:polarstar_flutter/app/data/model/model.dart';
import 'package:polarstar_flutter/app/data/repository/login_repository.dart';
import 'package:polarstar_flutter/app/routes/app_pages.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {
  final LoginRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  final _postsList = List<MyModel>().obs;
  get postList => this._postsList.value;
  set postList(value) => this._postsList.value = value;

  final _post = MyModel().obs;
  get post => this._post.value;
  set post(value) => this._post.value = value;

  adicionar(post) {}
  //dismissible
  excluir(id) {}
  //dismissible
  editar() {}
  details(post) {
    this.post = post;
    Get.toNamed(Routes.DETAILS);
  }
}
