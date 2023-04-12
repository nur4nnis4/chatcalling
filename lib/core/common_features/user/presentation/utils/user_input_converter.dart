import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/user.dart';
import 'package:chatcalling/core/helpers/time.dart';
import 'package:chatcalling/core/helpers/unique_id.dart';

const String DEFAULT_PROFILE_PHOTO_URL =
    'https://firebasestorage.googleapis.com/v0/b/chatcalling-63eb0.appspot.com/o/users%2Fmale-avatar.jpg?alt=media&token=98c3ad1d-7027-4e00-9b26-fbdd87f70042';

class UserInputConverter {
  final UniqueId uniqueId;
  final Time time;

  UserInputConverter({required this.uniqueId, required this.time});
  User toUser({
    required String username,
    required String displayName,
  }) =>
      User(
          userId: '',
          username: username,
          displayName: displayName,
          signUpTime: time.now(),
          isOnline: true,
          lastOnline: time.now(),
          about: '',
          profilePhotoUrl: DEFAULT_PROFILE_PHOTO_URL,
          coverPhotoUrl: '',
          friendList: []);

  PersonalInformation toPersonalInformation({required String email}) =>
      PersonalInformation(
          userId: '',
          email: email,
          phoneNumber: '',
          gender: 'Prefer not to say',
          dateOfBirth: DateTime(1900, 01, 01));
}
