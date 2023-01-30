import 'package:chatcalling/core/common_features/user/data/models/personal_information_model.dart';
import 'package:chatcalling/core/common_features/user/data/models/user_full_info_model.dart';
import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';
import 'package:chatcalling/core/common_features/user/data/utils/auth_error_message.dart';
import 'package:chatcalling/core/error/exceptions.dart';
import 'package:chatcalling/core/helpers/time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDatasource {
  Future<String> getCurrentUserId();
  Stream<bool> isSignedIn();
  bool isEmailVerified();
  Future<UserFullInfoModel?> signInWithGoogle();
  Future<void> signInWithEmail(String email, String password);
  Future<void> signUpWithEmail(String email, String password);
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<void> updatePassword(String newPassword);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final Time time;
  final AuthErrorMessage authErrorMessage;

  AuthRemoteDatasourceImpl({
    required this.time,
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.authErrorMessage,
  });

  late User? _currentUser = firebaseAuth.currentUser;

  Future<void> linkAuthProviders(AuthCredential authCredential) async {
    // TODO: learn more about LinkWithCredential
    try {
      _currentUser!.linkWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      throw PlatformException(message: authErrorMessage.toSentence(e.code));
    } catch (e) {
      throw PlatformException(message: e.toString());
    }
  }

  @override
  Future<String> getCurrentUserId() async {
    return firebaseAuth
        .authStateChanges()
        .map((currentUser) => currentUser!.uid)
        .first;
  }

  @override
  Stream<bool> isSignedIn() async* {
    yield* firebaseAuth
        .authStateChanges()
        .map((currentUser) => currentUser != null && !currentUser.isAnonymous);
  }

  @override
  bool isEmailVerified() {
    return _currentUser!.emailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await _currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw PlatformException(message: authErrorMessage.toSentence(e.code));
    } catch (e) {
      throw PlatformException(message: e.toString());
    }
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw PlatformException(message: authErrorMessage.toSentence(e.code));
    } catch (e) {
      throw PlatformException(message: e.toString());
    }
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw PlatformException(message: authErrorMessage.toSentence(e.code));
    } catch (e) {
      throw PlatformException(message: e.toString());
    }
  }

  @override
  Future<UserFullInfoModel?> signInWithGoogle() async {
    try {
      final googleAccout = await googleSignIn.signIn();

      final googleAuth = await googleAccout?.authentication;
      final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(authCredential);

      if (userCredential.additionalUserInfo?.isNewUser ?? true) {
        final googleUser = userCredential.user!;
        final personalInformation = PersonalInformationModel(
            userId: googleUser.uid,
            email: googleUser.email ?? '',
            phoneNumber: googleUser.phoneNumber ?? '',
            gender: 'Prefer not to say');
        final user = UserModel(
            userId: googleUser.uid,
            username: googleUser.uid,
            displayName: googleUser.displayName ?? '',
            profilePhotoUrl: googleUser.photoURL ?? '',
            about: '',
            isOnline: true,
            friendList: [],
            coverPhotoUrl: '',
            lastOnline: time.now(),
            signUpTime: time.now());
        return UserFullInfoModel(
            user: user, personalInformation: personalInformation);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('error' + e.code);
      throw PlatformException(message: authErrorMessage.toSentence(e.code));
    } catch (e) {
      print('error' + e.toString());
      throw PlatformException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
      await firebaseAuth.signOut();
    } catch (e) {
      throw PlatformException(message: e.toString());
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await _currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw PlatformException(message: authErrorMessage.toSentence(e.code));
    } catch (e) {
      throw PlatformException(message: e.toString());
    }
  }
}
