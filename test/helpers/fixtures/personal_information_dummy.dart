import 'package:chatcalling/core/common_features/user/data/models/personal_information_model.dart';
import 'package:chatcalling/core/common_features/user/domain/entities/personal_information.dart';

final tPersonalInformation = PersonalInformation(
    userId: 'user1Id',
    email: 'email',
    phoneNumber: 'phoneNumber',
    gender: 'gender',
    dateOfBirth: DateTime.parse('2022-07-18T16:37:47.475845Z').toLocal());

final tPersonalInformationModel = PersonalInformationModel(
    userId: 'user1Id',
    email: 'email',
    phoneNumber: 'phoneNumber',
    gender: 'gender',
    dateOfBirth: DateTime.parse('2022-07-18T16:37:47.475845Z').toLocal());

final tNewPersonalInformationModel = PersonalInformationModel(
    userId: 'newUserId',
    email: 'email',
    phoneNumber: 'phoneNumber',
    gender: 'gender',
    dateOfBirth: DateTime.parse('2022-07-18T16:37:47.475845Z').toLocal());

final tNewPersonalInformationWithoutUserId = PersonalInformation(
    userId: '',
    email: 'email',
    phoneNumber: 'phoneNumber',
    gender: 'gender',
    dateOfBirth: DateTime.parse('2022-07-18T16:37:47.475845Z').toLocal());

final tUpdatePersonalInformationModel = PersonalInformationModel(
    userId: 'user1Id',
    email: 'email',
    phoneNumber: 'updatePhoneNumber',
    gender: 'gender',
    dateOfBirth: DateTime.parse('2022-07-18T16:37:47.475845Z').toLocal());

final tPersonalInformationJson = {
  'userId': 'user1Id',
  'email': 'email',
  'phoneNumber': 'phoneNumber',
  'gender': 'gender',
  'dateOfBirth': '2022-07-18T16:37:47.475845Z'
};
