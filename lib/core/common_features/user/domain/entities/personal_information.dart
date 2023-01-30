import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PersonalInformation extends Equatable {
  final String userId;
  String email;
  String phoneNumber;
  String gender;
  DateTime? dateOfBirth;

  PersonalInformation({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.dateOfBirth,
  });

  @override
  List<Object?> get props => [
        userId,
        email,
        phoneNumber,
        gender,
        dateOfBirth,
      ];
}
