import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class AuthService {

  // Google Sign in
  signInWithGoogle() async {

    // interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // finaly, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  signInWithFacebook() async {
    // Start the sign-in process for Facebook
    final LoginResult result = await FacebookAuth.instance.login();

    // Check if the sign-in was successful
    if (result.status == LoginStatus.success) {
      // Get the access token for the user
      final AccessToken accessToken = result.accessToken!;
      // Create a credential with the access token
      final AuthCredential credential = FacebookAuthProvider.credential(
          accessToken.token);
      // Sign in with the credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      // Handle the sign-in error
      throw FirebaseAuthException(
        code: 'facebook_sign_in_failed',
        message: result.message,
      );
    }
  }

  signInWithApple() {

  }

}