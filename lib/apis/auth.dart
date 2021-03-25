import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:punchme/models/user_m.dart';

abstract class AuthRepo {
  Future<UserCredential> login(String email, String password);
  Future<UserCredential> register(String email, String password);
  Future<void> createUserDetails(UserM userM);
  Future<UserM> getUserDetails();
  Future<void> updateUserDetails(Map<String, dynamic> data,bool updateImage);
  Future<void> sendPasswordResetLink(String email);
  Future<UserCredential> googleLogin();
  Future<UserCredential> facebookLogin();
}

class AuthApis extends AuthRepo {
  final auth = FirebaseAuth.instance;
  final userStore = FirebaseFirestore.instance.collection('users');
  final storesStorage = FirebaseStorage.instance.ref().child('services');


  @override
  Future<UserCredential> login(String email, String password) async {
    return await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<UserCredential> register(String email, String password) async {
    return await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> createUserDetails(UserM userM) async {
    await userStore.doc(userM.id).set(userM.toJson(), SetOptions(merge: true));
  }

  @override
  Future<UserM> getUserDetails() async {
    final data = await userStore.doc(auth.currentUser.uid).get();
    return UserM.fromJson(data.data());
  }

  @override
  Future<void> updateUserDetails(Map<String, dynamic> data,bool updateImage) async {
    await userStore.doc(auth.currentUser.uid).update(data);
  }

  @override
  Future<void> sendPasswordResetLink(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential> googleLogin() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await auth.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> facebookLogin() async {}

  @override
  Future<void> removeImage(String imageData) async {
     await storesStorage.de(url).then((value) {
          value.delete();
          store.doc(productDetails.pid).delete().then((value) {
            dialogs.dismiss(context);
            dialogs.notice(
                context, 'Deleted', 'Your product has been deleted', goBack);
          }).catchError((e) {
            print(e);
            dialogs.dismiss(context);
            dialogs.error(
                context, 'Something went wrong, try again later...', null);
          });
        }).catchError((e) {
          print(e);
          dialogs.dismiss(context);
          dialogs.error(
              context, 'Something went wrong, try again later...', null);
        });
      });
  }

  //  Future<UserM> facebookSignIn() async {
  //   String result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => CustomWebView(
  //                 selectedUrl:
  //                     'https://www.facebook.com/dialog/oauth?client_id=$clientFBid&redirect_uri=$redirectUrl&response_type=token&scope=email,public_profile,',
  //               ),
  //           maintainState: true));
  //   if (result != null) {
  //     final facebookAuthCred = FacebookAuthProvider.credential(result);
  //     final User user =
  //         (await auth.signInWithCredential(facebookAuthCred)).user;
  //     return UserM(
  //         id: user.uid,
  //         email: user.email,
  //         name: user.displayName,
  //         phone: user.phoneNumber);
  //   } else
  //     return null;
  // }
}
