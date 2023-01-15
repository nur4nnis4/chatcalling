import '../../domain/entities/personal_information.dart';

class PersonalInformationModel extends PersonalInformation {
  PersonalInformationModel(
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

  factory PersonalInformationModel.fromJson(Map<String, dynamic>? json) =>
      PersonalInformationModel(
        userId: json?['userId'],
        email: json?['email'],
        phoneNumber: json?['phoneNumber'],
        gender: json?['gender'],
        dateOfBirth: DateTime.parse(json?['dateOfBirth']).toLocal(),
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toUtc().toIso8601String(),
    };
  }

  factory PersonalInformationModel.fromEntity(
          PersonalInformation personalInformation, String userId) =>
      PersonalInformationModel(
          userId: userId,
          email: personalInformation.email,
          phoneNumber: personalInformation.phoneNumber,
          gender: personalInformation.gender,
          dateOfBirth: personalInformation.dateOfBirth);
}
