import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get_connect.dart';
import '../../core/app_export.dart';
import 'facebook_user.dart';
class FacebookAuthHelper extends GetConnect {
  // firebase
  /// Handle Facebook SignIn to authenticate user
  Future<FacebookUser> facebookSignInProcess() async {
    final facebookLogin = FacebookLogin();
    final FacebookLoginResult result = await facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    switch (result.status) {
      case FacebookLoginStatus.success:
      // Logged in

      // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = result.accessToken;
        print('Access token: ${accessToken!.token}');
        break;
      case FacebookLoginStatus.cancel:
      // User cancel log in
        break;
      case FacebookLoginStatus.error:
      // Log in failed
        print('Error while log in: ${result.error}');
        break;
    }

    final FacebookAccessToken accessToken = result.accessToken!;
    final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
    await FirebaseAuth.instance.signInWithCredential(credential);
    return fetchUserProfile(result.accessToken!.token);
  }
  /// Method to fetch loggedIn user profile
  Future<FacebookUser> fetchUserProfile(String token) async {
    final graphResponse = await httpClient.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
    final profile = json.decode(graphResponse.body);
    return FacebookUser.fromMap(profile);
  }

  /// To sign out from the application if the user is signed in through facebook
  void facebookSignOutProcess() async {
    final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logOut();
    return facebookLoginResult;
  }
}
