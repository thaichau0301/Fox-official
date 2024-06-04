import '../../../core/app_export.dart';
import '../../../domain/googleauth/google_auth_helper.dart';
import '../../home_bottom_navigation/controller/home_bottom_navigation_controller.dart';
import '../models/login_model.dart';
import 'package:fox/domain/facebookauth/flutter_facebook_auth_login.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class LoginController extends GetxController {

  Rx<LoginModel> loginModelObj = LoginModel().obs;
  SignInWithGoogle() async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
      if (googleUser != null) {
        Get.delete<HomeBottomBarController>(force: true);
        Get.toNamed('/home_bottom_navigation');
      }
      else
      {
        Get.snackbar('Error', 'user data is empty');
      }
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
    });
  }

  SignInWithFacebook() async {
    // await FacebookAuthHelper()
    //     .facebookSignInProcess()
    //     .then((facebookUser) {})
    //     .catchError((onError) {
    //   Get.snackbar('Error', onError.toString());
    // });
    // Get.toNamed('/home_bottom_navigation');
    await CustomFacebookAuth().signInWithFacebook();
    Get.delete<HomeBottomBarController>(force: true);
    Get.toNamed('/home_bottom_navigation');
  }

  SignInWithEmail() {
  }
}
