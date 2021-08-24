import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polarstar_flutter/app/controller/mail/mail_controller.dart';
import 'package:polarstar_flutter/app/data/model/mail/mailSend_model.dart';

class MailBox extends StatelessWidget {
  final MailController mailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('polarStar'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
        ),
        body: RefreshIndicator(
          onRefresh: mailController.getMailBox,
          child: Stack(
            children: [
              ListView(),
              Obx(() {
                //데이터가 사용가능한 상태인지 확인
                if (mailController.dataAvailalbeMailPage) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var item in mailController.mailBox)
                          InkWell(
                            onTap: () async {
                              mailController.MAIL_BOX_ID.value =
                                  item.MAIL_BOX_ID;
                              //처음에 정보(쪽지 주고 받은 내역) 받고 보냄
                              await mailController.getMail();
                              Get.toNamed("/mailBox/sendMail");
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 10,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.0)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      //상대방 닉네임 or 익명
                                      child: Text(
                                        "${item.PROFILE_NICKNAME}",
                                        textScaleFactor: 1.2,
                                      ),
                                      flex: 30,
                                    ),
                                    Expanded(
                                      //최근 내용
                                      child: Text(
                                        "${item.CONTENT}",
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.2,
                                      ),
                                      flex: 100,
                                    ),
                                    Expanded(
                                      //문자 보낸 시각
                                      child: Text(
                                        "${item.TIME_CREATED}",
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1,
                                      ),
                                      flex: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
            ],
          ),
        ));
  }
}

class SendMail extends StatelessWidget {
  MailController mailController = Get.find(); //이미 있는 컨트롤러라 find
  final commentWriteController = TextEditingController();
  //스크롤 초기 설정 필요함
  ScrollController controller =
      new ScrollController(initialScrollOffset: 10000);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        mailController
            .setDataAvailableMailSendPageFalse(); //뒤로가기 눌렀을때 이 메일함의 dataavailabe을 false로 설정
        Get.back();
        return;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('polarStar'),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
          ),
          body: RefreshIndicator(
            onRefresh: mailController.getMail,
            child: Stack(
              children: [
                ListView(),
                Obx(() {
                  if (mailController.dataAvailableMailSendPage) {
                    //data가 available한 상태인지 확인
                    return Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: ListView.builder(
                        controller: controller,
                        itemCount: mailController.mailHistory.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) {
                          if (index == mailController.mailHistory.length - 1) {
                            print((mailController.mailHistory[index].FROM_ME));
                          }
                          return Container(
                              padding:
                                  EdgeInsets.only(left: 14, right: 14, top: 10),
                              child: Align(
                                alignment: (mailController
                                            .mailHistory[index].FROM_ME ==
                                        0
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (mailController
                                                .mailHistory[index].FROM_ME ==
                                            0
                                        ? Colors.grey.shade400
                                        : Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: (mailController
                                              .mailHistory[index].FROM_ME ==
                                          0
                                      ? Text(
                                          '${mailController.opponentProfile["PROFILE_NICKNAME"]} : ${mailController.mailHistory[index].CONTENT}',
                                          style: TextStyle(fontSize: 15))
                                      : Text(
                                          '${mailController.mailHistory[index].CONTENT}',
                                          style: TextStyle(fontSize: 15))),
                                ),
                              ));
                        },
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })
              ],
            ),
          ),
          //입력창
          bottomSheet: Container(
            height: 60,
            child: Stack(children: [
              //키보드
              Container(
                child: TextFormField(
                  controller: commentWriteController,
                  onFieldSubmitted: (value) {
                    mailController.sendMailIn(
                        commentWriteController.text, controller);
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintText: "쪽지 보내기", border: OutlineInputBorder()),
                ),
              ),
              Positioned(
                top: 15,
                right: 20,
                child: InkWell(
                  onTap: () {
                    mailController.sendMailIn(
                        commentWriteController.text, controller);

                    commentWriteController.clear();
                  },
                  child: Icon(
                    Icons.send,
                    size: 30,
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
