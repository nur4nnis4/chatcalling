import 'package:chatcalling/core/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required String userId,
      required String username,
      required String displayName,
      required DateTime signUpTime,
      required bool isOnline,
      required DateTime lastOnline,
      required String about,
      required String photoUrl})
      : super(
            userId: userId,
            username: username,
            displayName: displayName,
            signUpTime: signUpTime,
            isOnline: isOnline,
            lastOnline: lastOnline,
            about: about,
            photoUrl: photoUrl);

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
      userId: json?["userId"],
      username: json?["username"],
      displayName: json?["displayName"],
      signUpTime: DateTime.parse(json?["signUpTime"]),
      isOnline: json?["isOnline"],
      lastOnline: DateTime.parse(json?["lastOnline"]),
      about: json?["about"],
      photoUrl: json?["photoUrl"]);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "displayName": displayName,
        "signUpTime": signUpTime.isUtc
            ? signUpTime.toIso8601String()
            : signUpTime.toUtc().toIso8601String(),
        "isOnline": isOnline,
        "lastOnline": lastOnline.isUtc
            ? lastOnline.toIso8601String()
            : lastOnline.toUtc().toIso8601String(),
        "about": about,
        "photoUrl": photoUrl,
      };
}
