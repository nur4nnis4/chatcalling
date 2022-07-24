import 'package:equatable/equatable.dart';

class UserPrivateData extends Equatable {
  final String userId;
  final String email;
  final String phoneNumber;
  final DateTime gender;
  final DateTime dateOfBirth;

  const UserPrivateData({
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
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
