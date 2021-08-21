import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:polarstar_flutter/app/controller/board/post_controller.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:polarstar_flutter/app/controller/board/write_post_controller.dart';
import 'package:polarstar_flutter/app/data/model/board/write_post_model.dart';

class WritePost extends StatelessWidget {
  XFile _image;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  WritePostController c = Get.find();

  Map arg = Get.arguments;

  final ImagePicker _picker = ImagePicker();
  TextEditingController photoName = TextEditingController();

  // getGalleryImage(String titleStr, String contentStr) async {
  //   var img = await _picker.pickImage(source: ImageSource.gallery);
  //   // print(titleStr);
  //   setState(() {
  //     _image = img;
  //     title.text = titleStr;
  //     content.text = contentStr;
  //   });
  // }

  // getCameraImage(String title, String content) async {
  //   var img = await _picker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = img;
  //   });
  // }

  // Future upload(Map arg, XFile imageFile, Map data) async {
  //   var request = arg['myself'] != null && arg['myself']
  //       ? Session().multipartReq('PUT', '/board/bid/${arg['item']['bid']}')
  //       : Session().multipartReq('POST', '/board/${arg['type']}');

  //   var pic = await http.MultipartFile.fromPath("photo", imageFile.path);
  //   //contentType: new MediaType('image', 'png'));

  //   request.files.add(pic);
  //   request.fields['title'] = data['title'];
  //   request.fields['description'] = data['description'];
  //   request.fields['unnamed'] = data['unnamed'];
  //   // print(request.files[0].filename);
  //   var response = await request.send();
  //   print(response.statusCode);
  //   return response;
  // }

  // @override
  // void initState() {
  //   if (arg['item'] != null) {
  //     setState(() {
  //       title.text = arg['item']['title'].toString();
  //       content.text = arg['item']['content'].toString();
  //       if (arg['item']['photo'] != '' || arg['item']['photo'] == null) {
  //         _image = XFile(
  //             'http://ec2-3-37-156-121.ap-northeast-2.compute.amazonaws.com:3000${arg['item']['photo']}');
  //       }
  //     });
  //   }

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('polarStar'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  Map data = WritePostModel(
                          title: title.text,
                          description: content.text,
                          unnamed: (c.anonymousCheck.value) ? '1' : '0')
                      .toJson();

                  print(c.anonymousCheck.value);
                  print(data);

                  await c.postPost(data);

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
                      // getGalleryImage(title.text, content.text);
                    },
                    child: Icon(Icons.photo),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      // getCameraImage(title.text, content.text);
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
                            // c.changeAnonymous(value);
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
