import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/login_controller.dart'; // ignore_for_file: must_be_immutable
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              _buildLoginColumnIconFox(),
              const Spacer(
                flex: 3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    customButtonSignIn(controller.SignInWithGoogle, FontAwesomeIcons.google,
                        'Continue with Google', Colors.white),
                    const SizedBox(height: 16,),
                    customButtonSignIn(controller.SignInWithFacebook, FontAwesomeIcons.facebook,
                        'Continue with Facebook', Colors.blue),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget customButtonSignIn(VoidCallback func, icon, label, customColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: func,
        icon: Padding(
          padding: EdgeInsets.only(right: 50),
            child: Icon(icon, color: Colors.black,)
        ),
        label: Text(label, style: TextStyle(fontSize: 16, color: Colors.black), textAlign: TextAlign.center ,),
            style: ElevatedButton.styleFrom(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              backgroundColor: customColor,
              overlayColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(color: Colors.black.withOpacity(0.5), width: 1),
            ),
          ),
      ),
    );
  }
  Widget _buildLoginColumnIconFox() {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          child: Image.asset('assets/images/img_icon_fox.png'),
        ),
        Container(
          child: const Text('FOX', style: TextStyle(fontSize: 60,),)
        )
      ],
    );
  }
}
