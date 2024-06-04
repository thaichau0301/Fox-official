import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/theme_helper.dart';
import 'controller/user_controller.dart'; // ignore_for_file: must_be_immutable
import 'package:fox/theme/primitives.dart';

class UserScreen extends GetWidget<UserController> {
  const UserScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final primitives = Get.put(Primitives());
    final userController = Get.find<UserController>();
    return Scaffold(
      backgroundColor: appTheme.gray100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(
            flex: 1,
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(
                () => Row(
                  children: [
                    CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.black12,
                        child: userController.photoUrl.value == ''
                            ? Icon(Icons.person, size: 50)
                            : Image.network(
                                userController.photoUrl.value,
                                fit: BoxFit.fill,
                              )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        if (userController.email.value == '') {
                          Get.toNamed('/initialRoute');
                        }
                      },
                      style: TextButton.styleFrom(
                          overlayColor: Colors.transparent),
                          child: Text(
                            userController.email.value == ''
                              ? 'Login'
                              : userController.email.value,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.only(left: primitives.spacing_lg),
              child: Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: primitives.font_sm,
                  )
              )
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              dialogConfirm('Do you wish to log out?', 'Log out',
                  userController.SignOutUser);
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(),
                alignment: Alignment.centerLeft,
                overlayColor: Colors.transparent,
                padding: EdgeInsets.only(left: primitives.spacing_lg)
            ),
                child: Text(
                    'Log out',
                    style: TextStyle(
                        fontSize: primitives.font_lg, color: Colors.black)
                ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: primitives.spacing_lg),
              child: Text(
                  'Delete account',
                  style: TextStyle(fontSize: primitives.font_sm)
              )
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              dialogConfirm('Do you wish to delete account?', 'Delete',
                  userController.DeleteAccount);
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(),
                alignment: Alignment.centerLeft,
                overlayColor: Colors.transparent,
                padding: EdgeInsets.only(left: primitives.spacing_lg)
                ),
                child: Text(
                    'Delete account',
                    style: TextStyle(fontSize: primitives.font_lg, color: Colors.black)
                ),
          ),
          Spacer(
            flex: 10,
          ),
        ],
      ),
    );
  }

  void dialogConfirm(String content, String confirmText, Future<void> func()) {
    Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.zero,
      content: Text(
        content,
        style: TextStyle(fontSize: 13),
      ),
      buttonColor: Colors.white,
      confirm: TextButton(
          onPressed: () {
            Get.back(
                result: true); // Đóng dialog ngay lập tức khi nhấn nút xác nhận
            Future.delayed(Duration(microseconds: 100), () async {
              await func(); // Chạy func() trong microtask
            }
            );
          },
          child: Text(
            confirmText,
            style: TextStyle(color: Colors.blue, fontSize: 15),
          )),
      cancel: TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
      ),
    );
  }
}
