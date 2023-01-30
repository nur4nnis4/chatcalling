import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  final String userId;
  String username;
  String displayName;
  DateTime signUpTime;
  bool isOnline;
  DateTime lastOnline;
  String about;
  String profilePhotoUrl;
  String coverPhotoUrl;
  List<String> friendList;

  User({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.signUpTime,
    required this.isOnline,
    required this.lastOnline,
    required this.about,
    required this.profilePhotoUrl,
    required this.coverPhotoUrl,
    required this.friendList,
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        displayName,
        signUpTime,
        isOnline,
        lastOnline,
        about,
        profilePhotoUrl,
        coverPhotoUrl,
        friendList,
      ];
}
