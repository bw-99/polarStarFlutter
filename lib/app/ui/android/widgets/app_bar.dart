import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('polarStar'),
      actions: [
        IconButton(
            onPressed: () {
              // Session().getX('/logout');
              // Session.cookies = {};
              // Session.headers['Cookie'] = '';
              // box.remove('pw');
              // box.remove('isloggined');
              // box.remove('token');
              // // Navigator.pushNamedAndRemoveUntil(
              // //     context, '/login', (Route<dynamic> route) => false);
              // Get.offAllNamed('/login');
            },
            icon: Text('LOGOUT')),
        IconButton(
            onPressed: () {
              // Get.toNamed('/myPage');
            },
            icon: Icon(Icons.person)),
      ],
    );
  }
}

class WritePostAppBar extends StatelessWidget with PreferredSizeWidget {
  final int COMMUNITY_ID;

  WritePostAppBar({this.COMMUNITY_ID});

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    print(COMMUNITY_ID);
    return AppBar(
      title: Text('polarStar'),
      actions: [
        Container(
          width: 40,
          child: InkWell(
              onTap: () {
                Get.toNamed('/board/$COMMUNITY_ID');
              },
              child: Icon(
                Icons.add,
              )),
        )
      ],
    );
  }
}
