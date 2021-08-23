// 핫게 위젯
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/data/model/main_model.dart';

Widget billboardContent(HotBoard hotBoard) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      primary: Colors.black,
    ),
    onPressed: () {
      Get.toNamed('/board/${hotBoard.COMMUNITY_ID}/read/${hotBoard.BOARD_ID}');
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text(hotBoard.COMMUNITY_NAME.toString())),
        Spacer(),
        Container(
          width: 200,
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${hotBoard.TITLE}",
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${hotBoard.CONTENT}",
                  textAlign: TextAlign.left,
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
        Spacer(),
      ],
    ),
  );
}

// 게시판 목록 위젯
Widget boards(List<BoardInfo> data) {
  List<Widget> boardList = [];

  data.forEach((value) {
    boardList.add(board(value.COMMUNITY_ID, value.COMMUNITY_NAME));
  });

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: boardList,
  );
}

// 게시판 위젯
Widget board(int COMMUNITY_ID, String COMMUNITY_NAME) {
  return Padding(
    padding: const EdgeInsets.all(1),
    child: Container(
      decoration: BoxDecoration(color: Colors.lightGreen),
      width: Get.mediaQuery.size.width - 18,
      height: 25,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: () {
          Get.toNamed('/board/$COMMUNITY_ID/page/1');
        },
        child: Text(
          COMMUNITY_NAME,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
