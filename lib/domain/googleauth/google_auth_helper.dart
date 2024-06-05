import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class GoogleAuthHelper {
  var user = Rx<GoogleSignInAccount?>(null);
  /// Handle Google Signin to authenticate user
   late GoogleSignIn googleSignIn;
  Future<GoogleSignInAccount?> googleSignInProcess() async {
    googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // user for update UI
      user.value = googleUser;
      return googleUser;
    }
    return null;
  }

  /// To Check if the user is already signedin through google
  alreadySignIn() async {
    googleSignIn = GoogleSignIn();
    bool alreadySignIn = await googleSignIn.isSignedIn();
    return alreadySignIn;
  }
}
