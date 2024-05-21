import '../../../core/app_export.dart';
import '../../../domain/facebookauth/facebook_auth_helper.dart';
import '../../../domain/googleauth/google_auth_helper.dart';
import '../../../routes/app_routes.dart';
import '../models/login_model.dart';
import 'package:fox/domain/facebookauth/flutter_facebook_auth_login.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class LoginController extends GetxController {


  @override
  void onInit(){
    super.onInit();
    print('onInit of login screen');


  }
  void onReady() {
    print('onReady  of login screen');

  }

  Rx<LoginModel> loginModelObj = LoginModel().obs;
  SignInWithGoogle() async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
      if (googleUser != null) {
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
    Get.toNamed('/home_bottom_navigation');
  }

  SignInWithEmail() {
  }
}
