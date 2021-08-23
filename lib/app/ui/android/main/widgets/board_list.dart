import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/controller/main/main_controller.dart';
import 'package:polarstar_flutter/app/data/model/main_model.dart';

class BoardList extends StatelessWidget {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController boardNameController = TextEditingController();
    return Obx(() {
      if (mainController.dataAvailalbe) {
        return SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    // Hot
                    Container(child: hotBoard()),
                    // Recruit
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.lightBlue[100]),
                        width: Get.mediaQuery.size.width - 18,
                        height: 100,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          onPressed: () {
                            Get.toNamed('/outside/1/page/1');
                          },
                          child: Text(
                            'RECRUIT',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '전체 게시판 목록',
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 20,
                            width: 150,
                            child: TextFormField(
                              controller: boardNameController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(9)
                              ],

                              // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            ),
                          ),
                          // 게시판 추가
                          InkWell(
                            onTap: () {
                              // Session().postX('/board', {
                              //   'boardName': boardNameController.text
                              // }).then((value) {
                              //   print(value.statusCode);
                              //   switch (value.statusCode) {
                              //     case 200:
                              //       setState(() {});
                              //       break;
                              //     default:
                              //   }
                              // });
                            },
                            child: Icon(Icons.add),
                          )
                        ],
                      ),
                    ),
                    Container(child: boards(mainController.boardInfo))
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}

Widget boards(List<BoardInfo> data) {
  List<Widget> boardList = [];

  data.forEach((element) {
    boardList
        .add(board(element.COMMUNITY_ID.toString(), element.COMMUNITY_NAME));
  });

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: boardList,
  );
}

// 게시판 위젯
Widget board(String boardtype, dynamic boardName) {
  return Padding(
    padding: const EdgeInsets.all(1),
    child: Container(
      decoration: BoxDecoration(color: Colors.lightBlue[100]),
      width: Get.mediaQuery.size.width - 18,
      height: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: () {
          Get.toNamed('/board/$boardtype/page/1');
        },
        child: Text(
          boardName.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget hotBoard() {
  return Padding(
    padding: const EdgeInsets.all(1),
    child: Container(
      decoration: BoxDecoration(color: Colors.lightBlue[100]),
      width: Get.mediaQuery.size.width - 18,
      height: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: () {
          Get.toNamed('/board/hot/page/1');
        },
        child: Text(
          'HOT',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
