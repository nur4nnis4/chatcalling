import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String username;
  final String displayName;
  final DateTime signUpTime;
  final bool isOnline;
  final DateTime lastOnline;
  final String about;
  final String profilePhotoUrl;
  final String coverPhotoUrl;
  final List<String> friendList;

  const User({
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
