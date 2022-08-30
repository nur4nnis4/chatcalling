import 'package:chatcalling/core/user/domain/entities/user_private_data.dart';

class UserPrivateDataModel extends UserPrivateData {
  UserPrivateDataModel(
      {required String userId,
      required String email,
      required String phoneNumber,
      required String gender,
      required DateTime dateOfBirth})
      : super(
            userId: userId,
            email: email,
            phoneNumber: phoneNumber,
            gender: gender,
            dateOfBirth: dateOfBirth);
}
