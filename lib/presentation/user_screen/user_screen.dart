import 'package:flutter/material.dart';
import 'package:fox/theme/primitives.dart';
import '../../core/app_export.dart';
import '../../theme/theme_helper.dart';
import 'controller/user_controller.dart'; // ignore_for_file: must_be_immutable

Primitives primitives = new Primitives();

class UserScreen extends GetWidget<UserController> {
  UserScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal:  15.0, vertical: 20),
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
            CustomTextButton(
                'Log out',
                () => dialogConfirm('Do you wish to log out?', 'Log out',
                    userController.SignOutUser)),
            CustomTextButton(
                'Delete account',
                () => dialogConfirm('Do you wish to delete account?', 'Delete',
                    userController.DeleteAccount)),
          ],
        ),
      ),
    );
  }
  Widget CustomTextButton(String text, VoidCallback onPress) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(),
            alignment: Alignment.centerLeft,
            overlayColor: Colors.transparent,
            padding: EdgeInsets.only(left: 16)
        ),
        child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.black)
        ),
      ),
    );
  }

  Future<void> dialogConfirm(String content, String confirmText, Future<void> func())  async {
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
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
      ),
    );
  }
}
