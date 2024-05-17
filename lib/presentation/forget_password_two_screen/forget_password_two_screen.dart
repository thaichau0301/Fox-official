import 'package:flutter/material.dart';
import 'package:fox/core/utils/size_utils.dart';
import '../../core/app_export.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import 'controller/forget_password_two_controller.dart'; // ignore_for_file: must_be_immutable

class ForgetPasswordTwoScreen extends GetWidget<ForgetPasswordTwoController> {
  const ForgetPasswordTwoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){Get.back();},
              icon: Icon(Icons.arrow_back_ios_new_outlined))
        ),
        body: Container(
          width: 360.h,
          padding: EdgeInsets.symmetric(
            horizontal: 22.h,
            vertical: 33.v,
          ),
          child: Column(
            children: [
              Text(
                "msg_enter_a_6_digital".tr,
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 9.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "msg_your_code_was_emailed2".tr,
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: "msg_ng_0_gmail_com".tr,
                      style: CustomTextStyles.labelLargeInterBlack900,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 33.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Obx(
                      () => CustomPinCodeTextField(
                        context: Get.context!,
                        controller: controller.otpController.value,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.v),
              CustomElevatedButton(
                onPressed: () {Get.toNamed('/home_bottom_navigation');},
                text: "lbl_next".tr,
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }
}
