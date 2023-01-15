import 'package:chatcalling/core/common_features/user/data/models/personal_information_model.dart';
import 'package:chatcalling/core/common_features/user/data/models/user_model.dart';

class UserFullInfoModel {
  final UserModel user;
  final PersonalInformationModel personalInformation;
  UserFullInfoModel({required this.user, required this.personalInformation});
}
