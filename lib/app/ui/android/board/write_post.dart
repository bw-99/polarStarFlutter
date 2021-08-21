import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:polarstar_flutter/app/controller/board/post_controller.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:polarstar_flutter/app/controller/board/write_post_controller.dart';
import 'package:polarstar_flutter/app/data/model/board/post_model.dart';
import 'package:polarstar_flutter/app/data/model/board/write_post_model.dart';

class WritePost extends StatelessWidget {
  WritePostController c = Get.find();

  Post item = Get.arguments;

  final ImagePicker _picker = ImagePicker();
  TextEditingController photoName = TextEditingController();

  getGalleryImage(String titleStr, String contentStr) async {
    var img = await _picker.pickImage(source: ImageSource.gallery);
    c.image.value = img;
  }

  getCameraImage(String title, String content) async {
    var img = await _picker.pickImage(source: ImageSource.camera);
    c.image.value = img;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController title =
        TextEditingController(text: item == null ? "" : item.TITLE);
    final TextEditingController content =
        TextEditingController(text: item == null ? "" : item.CONTENT);

    return Scaffold(
      appBar: AppBar(
        title: Text('polarStar'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  Map<String, dynamic> data = WritePostModel(
                          title: title.text,
                          description: content.text,
                          unnamed: (c.anonymousCheck.value) ? '1' : '0')
                      .toJson();

                  print(data);

                  //수정
                  if (c.putOrPost == "put") {
                    if (c.image.value != null) {
                      await c.putPostImage(data);
                    } else {
                      await c.putPostNoImage(data);
                    }
                  }
                  //작성
                  else {
                    if (c.image.value != null) {
                      await c.postPostImage(data);
                    } else {
                      await c.postPostNoImage(data);
                    }
                  }

                  // Get.offAndToNamed("/board/${c.COMMUNITY_ID}/page/1");

                  // if (_image != null) {
                  //   upload(arg, _image, data).then((value) {
                  //     switch (value.statusCode) {
                  //       case 200:
                  //         Get.back();

                  //         break;
                  //       case 401:
                  //         // Get.snackbar('login error', 'session expired');
                  //         // Session().getX('/logout');
                  //         // Get.offAllNamed('/login');
                  //         break;
                  //       case 403:
                  //         Get.snackbar('Forbidden', 'Forbidden');

                  //         break;
                  //       case 404:
                  //         Get.snackbar(
                  //             'Type is not founded', 'type is not founded');
                  //         Get.back();
                  //         break;
                  //       default:
                  //         print(value.statucCode);
                  //     }
                  //   });
                  // } else {
                  //   postPost(arg, data).then((value) {
                  //     print(value.statusCode);
                  //     switch (value.statusCode) {
                  //       case 200:
                  //         Get.back();

                  //         break;
                  //       case 401:
                  //         Get.snackbar('login error', 'session expired');
                  //         Session().getX('/logout');
                  //         Get.offAllNamed('/login');
                  //         break;
                  //       case 403:
                  //         Get.snackbar('Forbidden', 'Forbidden');

                  //         break;
                  //       case 404:
                  //         Get.snackbar(
                  //             'Type is not founded', 'type is not founded');
                  //         Get.back();
                  //         break;
                  //       default:
                  //         print(value.statucCode);
                  //     }
                  //   });
                  // }
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: c.putOrPost == "put" ? Text('수정') : Text('작성'),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: title,
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '제목을 작성하세요.',
              isDense: true,
            ),
          ),
          TextFormField(
            controller: content,
            // textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '내용을 작성하세요.',
              isDense: true,
            ),
            maxLines: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      getGalleryImage(title.text, content.text);
                    },
                    child: Icon(Icons.photo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      getCameraImage(title.text, content.text);
                    },
                    child: Icon(Icons.photo_camera),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 100,
                    height: 20,
                    child: TextField(
                      style: TextStyle(fontSize: 10),
                      enabled: false,
                      controller: photoName,
                      decoration: InputDecoration(hintText: 'photo name'),
                    ),
                  ),
                ),
                Spacer(),
                Obx(
                  () {
                    return Container(
                      height: 20,
                      width: 20,
                      child: Transform.scale(
                        scale: 1,
                        child: Checkbox(
                          value: c.anonymousCheck.value,
                          onChanged: (value) {
                            c.anonymousCheck.value = !c.anonymousCheck.value;
                            print(c.anonymousCheck.value);
                          },
                        ),
                      ),
                    );
                  },
                ),
                Text(' 익명'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
