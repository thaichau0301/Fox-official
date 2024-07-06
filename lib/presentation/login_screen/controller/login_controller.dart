import '../../../core/app_export.dart';
import '../../../domain/googleauth/google_auth_helper.dart';
import '../../home_bottom_navigation/controller/home_bottom_navigation_controller.dart';
import 'package:fox/domain/facebookauth/flutter_facebook_auth_login.dart';
/// current loginModelObj
class LoginController extends GetxController {
  SignInWithGoogle() async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) async {
      if (googleUser != null)  {
        Get.delete<HomeBottomBarController>(force: true);
        Get.toNamed('/home_screen');
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
    await CustomFacebookAuth().signInWithFacebook();
    Get.delete<HomeBottomBarController>(force: true);
    Get.toNamed('/home_screen');
  }
}
