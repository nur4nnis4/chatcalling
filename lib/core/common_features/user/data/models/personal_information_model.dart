import '../../domain/entities/personal_information.dart';

// ignore: must_be_immutable
class PersonalInformationModel extends PersonalInformation {
  PersonalInformationModel(
      {required String userId,
      required String email,
      required String phoneNumber,
      required String gender,
      DateTime? dateOfBirth})
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
        dateOfBirth: (json?['dateOfBirth'] as String).isNotEmpty
            ? DateTime.parse(json?['dateOfBirth']).toLocal()
            : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dateOfBirth':
          dateOfBirth != null ? dateOfBirth!.toUtc().toIso8601String() : '',
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
