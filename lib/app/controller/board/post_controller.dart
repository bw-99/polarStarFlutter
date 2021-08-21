import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:polarstar_flutter/app/data/model/board/post_model.dart';
import 'package:polarstar_flutter/app/data/model/login_model.dart';
import 'package:meta/meta.dart';
import 'package:polarstar_flutter/app/data/model/main_model.dart';
import 'package:polarstar_flutter/app/data/repository/board/post_repository.dart';
import 'package:polarstar_flutter/app/data/repository/main_repository.dart';
import 'package:polarstar_flutter/session.dart';

class PostController extends GetxController {
  final PostRepository repository;
  final box = GetStorage();

  PostController(
      {@required this.repository,
      @required this.COMMUNITY_ID,
      @required this.BOARD_ID})
      : assert(repository != null);

  Rx<bool> _dataAvailable = false.obs;

  int COMMUNITY_ID;
  int BOARD_ID;

  // Post
  var anonymousCheck = true.obs;
  Rx<bool> mailAnonymous = true.obs;
  RxList postContent = [].obs;
  RxList<Post> sortedList = <Post>[].obs;
  RxMap postBody = {}.obs;

  var isCcomment = false.obs;
  var ccommentUrl = ''.obs;
  var commentUrl = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    isCcomment(false);
    makeCommentUrl(COMMUNITY_ID, BOARD_ID);
    await getPostData();
  }

  Future<void> refreshPost() async {
    await getPostData();
  }

  Future<void> getPostData() async {
    _dataAvailable.value = false;
    final Map<String, dynamic> response =
        await repository.getPostData(this.COMMUNITY_ID, this.BOARD_ID);
    final status = response["statusCode"];

    switch (status) {
      case 401:
        Session().getX('/logout');
        Get.offAllNamed('/login');
        return null;
        break;
      case 400:
      case 200:
        sortPCCC(response["listPost"]);
        _dataAvailable.value = true;
        return;
      default:
    }
  }

  // void deletePost(int COMMUNITY_ID, int BOARD_ID) async {
  //   final status = await repository.deletePost(COMMUNITY_ID, BOARD_ID);
  //   switch (status) {
  //     case 200:
  //       Get.back();
  //       Get.snackbar("게시글 삭제 성공", "게시글 삭제 성공",
  //           snackPosition: SnackPosition.BOTTOM);

  //       await Get.offAllNamed("/board/$COMMUNITY_ID/page/1");

  //       break;
  //     default:
  //       Get.snackbar("게시글 삭제 실패", "게시글 삭제 실패",
  //           snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  void deleteResource(int COMMUNITY_ID, int UNIQUE_ID, String tag) async {
    final status =
        await repository.deleteResource(COMMUNITY_ID, UNIQUE_ID, tag);
    switch (status) {
      case 200:
        Get.snackbar("게시글 삭제 성공", "게시글 삭제 성공",
            snackPosition: SnackPosition.BOTTOM);

        if (tag == "bid") {
          Get.offAllNamed("/board/$COMMUNITY_ID/page/1");
        } else {
          await getPostData();
        }

        break;
      default:
        Get.snackbar("게시글 삭제 실패", "게시글 삭제 실패",
            snackPosition: SnackPosition.BOTTOM);
    }
  }

  void postComment(String url, var data) async {
    final status = await repository.postComment(url, data);
    switch (status) {
      case 200:
        await getPostData();
        break;

      default:
        break;
    }
  }

  void putComment(String url, var data) async {
    final status = await repository.putComment(url, data);
    switch (status) {
      case 200:
        await getPostData();
        break;

      default:
        break;
    }
  }

  void sortPCCC(List<Post> itemList) {
    sortedList.clear();

    sortedList.add(itemList[0]);

    int itemLength = itemList.length;

    //댓글 대댓글 정렬
    for (int i = 1; i < itemLength; i++) {
      Post unsortedItem = itemList[i];

      //게시글 - 댓글 - 대댓글 순서대로 정렬되있으므로 대댓글 만나는 순간 끝
      if (unsortedItem.DEPTH == 2) {
        print("break!");
        break;
      }

      //댓글 집어 넣기
      sortedList.add(itemList[i]);

      for (int k = 1; k < itemList.length; k++) {
        //itemlist를 돌면서 댓글을 부모로 가지는 대댓글 찾아서
        if (itemList[k].PARENT_ID == unsortedItem.UNIQUE_ID) {
          //sortedList에 집어넣음(순서대로)
          sortedList.add(itemList[k]);
        }
      }
    }
  }

  void totalSend(String urlTemp, String what) {
    String url = "/board" + urlTemp;
    Session().getX(url).then((value) {
      switch (value.statusCode) {
        case 200:
          Get.snackbar("$what 성공", "$what 성공",
              snackPosition: SnackPosition.BOTTOM);
          getPostData();
          break;
        case 403:
          Get.snackbar('이미 $what 한 게시글입니다', '이미 $what 한 게시글입니다',
              snackPosition: SnackPosition.BOTTOM);
          break;
        default:
      }
    });
  }

  void sendMail(
      int UNIQUE_ID, int COMMUNITY_ID, mailWriteController, mailController) {
    Get.defaultDialog(
      title: "쪽지 보내기",
      barrierDismissible: true,
      content: Column(
        children: [
          TextFormField(
            controller: mailWriteController,
            keyboardType: TextInputType.text,
            maxLines: 1,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  child: Transform.scale(
                    scale: 1,
                    child: Obx(() {
                      return Checkbox(
                        value: mailAnonymous.value,
                        onChanged: (value) {
                          mailAnonymous.value = value;
                        },
                      );
                    }),
                  ),
                ),
                Text(' 익명'),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                String content = mailWriteController.text;
                if (content.trim().isEmpty) {
                  Get.snackbar("텍스트를 작성해주세요", "텍스트를 작성해주세요");
                  return;
                }

                Map mailData = {
                  "UNIQUE_ID": '$UNIQUE_ID',
                  "PROFILE_UNNAMED": '1',
                  "CONTENT": '${content.trim()}',
                  "COMMUNITY_ID": '$COMMUNITY_ID'
                };
                //"target_mem_unnamed": '${item["unnamed"]}',

                print(mailData);
                var response = await Session().postX("/message", mailData);
                switch (response.statusCode) {
                  case 200:
                    Get.back();
                    Get.snackbar("쪽지 전송 완료", "쪽지 전송 완료",
                        snackPosition: SnackPosition.TOP);

                    int targetMessageBoxID =
                        jsonDecode(response.body)["MAIL_BOX_ID"];

                    print(jsonDecode(response.body));
                    print(jsonDecode(response.body));

                    mailController.MAIL_BOX_ID.value = targetMessageBoxID;

                    print(mailController.MAIL_BOX_ID.value);
                    await mailController.getMail();
                    Get.toNamed("/mailBox/sendMail");

                    break;
                  case 403:
                    Get.snackbar("다른 사람의 쪽지함입니다.", "다른 사람의 쪽지함입니다.",
                        snackPosition: SnackPosition.TOP);
                    break;

                  default:
                    Get.snackbar("업데이트 되지 않았습니다.", "업데이트 되지 않았습니다.",
                        snackPosition: SnackPosition.TOP);
                }

                // print(c.mailAnonymous.value);
                /*Get.offAndToNamed("/mailBox",
                                                arguments: {"unnamed": 1});*/
              },
              child: Text("발송"))
        ],
      ),
    );
    mailWriteController.clear();
  }

  Future<int> getArrestType() async {
    var response = await Get.defaultDialog(
        title: "신고 사유 선택",
        content: Column(
          children: [
            InkWell(
              child: Text("게시판 성격에 안맞는 글"),
              onTap: () {
                Get.back(result: 0);
              },
            ),
            InkWell(
              child: Text("선정적인 글"),
              onTap: () {
                Get.back(result: 1);
              },
            ),
            InkWell(
              child: Text("거짓 선동"),
              onTap: () {
                Get.back(result: 2);
              },
            ),
            InkWell(
              child: Text("비윤리적인 글"),
              onTap: () {
                Get.back(result: 3);
              },
            ),
            InkWell(
              child: Text("사기"),
              onTap: () {
                Get.back(result: 4);
              },
            ),
            InkWell(
              child: Text("광고"),
              onTap: () {
                Get.back(result: 5);
              },
            ),
            InkWell(
              child: Text("혐오스러운 글"),
              onTap: () {
                Get.back(result: 6);
              },
            ),
          ],
        ));
    return response;
  }

  changeAnonymous(bool value) {
    anonymousCheck.value = value;
  }

  changeCcomment(String cidUrl) {
    if (isCcomment.value && ccommentUrl.value == cidUrl) {
      isCcomment(false);
    } else {
      isCcomment(true);
    }
  }

  makeCcommentUrl(int COMMUNITY_ID, int cid) {
    ccommentUrl.value = '/board/$COMMUNITY_ID/cid/$cid';
  }

  makeCommentUrl(int COMMUNITY_ID, int bid) {
    commentUrl.value = '/board/$COMMUNITY_ID/bid/$bid';
  }

  // 댓글 수정
  var autoFocusTextForm = false.obs;
  var putUrl = ''.obs;

  updateAutoFocusTextForm(bool b) {
    autoFocusTextForm.value = b;
  }

  void getPostFromCommentData(Map comment) async {
    var response = await Session().getX(
        "/board/${comment['comment']['type']}/read/${comment['comment']['bid']}");
  }

  bool get dataAvailable => _dataAvailable.value;
}
