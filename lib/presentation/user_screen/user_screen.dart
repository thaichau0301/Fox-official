import 'package:flutter/material.dart';
import 'package:fox/theme/primitives.dart';
import '../../core/app_export.dart';
import '../../theme/theme_helper.dart';
import 'controller/user_controller.dart'; // ignore_for_file: must_be_immutable

Primitives primitives = new Primitives();
class UserScreen extends GetWidget<UserController> {
  const UserScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      backgroundColor: appTheme.gray100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(
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
                    const SizedBox(
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
          const SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.only(left: 16),
              child: const Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 12,
                  )
              )
          ),
          const SizedBox(
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
                padding: EdgeInsets.only(left: 16)
            ),
                child: const Text(
                    'Log out',
                    style: TextStyle(
                        fontSize: 16, color: Colors.black)
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: 16),
              child: const Text(
                  'Delete account',
                  style: TextStyle(fontSize: 12)
              )
          ),
          const SizedBox(
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
                padding: EdgeInsets.only(left: 16)
                ),
                child: const Text(
                    'Delete account',
                    style: TextStyle(fontSize: 16, color: Colors.black)
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: 16),
              child: const Text(
                  'Library',
                  style: TextStyle(fontSize: 12)
              )
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () async {
              await controller.listUserFiles();
              await Get.to(() => CustomLibraryUser(controller));
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(),
                alignment: Alignment.centerLeft,
                overlayColor: Colors.transparent,
                padding: EdgeInsets.only(left: 16)
            ),
            child: const Text(
                'Library',
                style: TextStyle(fontSize: 16, color: Colors.black)
            ),
          ),
          const Spacer(
            flex: 10,
          ),
        ],
      ),
    );
  }
  Widget CustomLibraryUser(UserController controller) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount: 2, // Adjust as needed
            ),
            itemCount: controller.imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:  5.0),
                child: GestureDetector(
                  onTap: () {
                    controller.onTapImage(controller.imageUrls.elementAt(index));
                  },
                    child: Image.network(controller.imageUrls.elementAt(index))
                ),
              );
            },
          ),
    ));
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
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
      ),
    );
  }
}
