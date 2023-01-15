abstract class AuthErrorMessage {
  String toSentence(String errorMessage);
}

class AuthErrorMessageImpl implements AuthErrorMessage {
  static const emailIsNotVerified = 'Please verify your email.';
  static const emailIsAlreadyUsed =
      'The account already exists for that email.';
  static const weakPassword = 'The password you entered is too weak.';
  static const wrongEmailAndPassword =
      'The email or password you entered did not match our records. Please double check and try again';
  static const disabledAccout = 'This user account has been disabled';

  @override
  String toSentence(String errorMessage) {
    switch (errorMessage) {
      case 'user-not-found':
        return wrongEmailAndPassword;
      case 'wrong-password':
        return wrongEmailAndPassword;
      case 'weak-password':
        return weakPassword;
      case 'email-already-in-use':
        return emailIsAlreadyUsed;
      case 'user-disabled':
        return disabledAccout;
      default:
        return 'Something went wrong';
    }
  }
}
