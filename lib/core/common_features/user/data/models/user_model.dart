import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String userId,
    required String username,
    required String displayName,
    required DateTime signUpTime,
    required bool isOnline,
    required DateTime lastOnline,
    required String about,
    required String profilePhotoUrl,
    required String coverPhotoUrl,
    required List<String> friendList,
  }) : super(
          userId: userId,
          username: username,
          displayName: displayName,
          signUpTime: signUpTime,
          isOnline: isOnline,
          lastOnline: lastOnline,
          about: about,
          profilePhotoUrl: profilePhotoUrl,
          coverPhotoUrl: coverPhotoUrl,
          friendList: friendList,
        );

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    final List<dynamic> friendListJson = json?['friendList'];
    return UserModel(
        userId: json?["userId"],
        username: json?["username"],
        displayName: json?["displayName"],
        signUpTime: DateTime.parse(json?["signUpTime"]).toLocal(),
        isOnline: json?["isOnline"],
        lastOnline: DateTime.parse(json?["lastOnline"]).toLocal(),
        about: json?["about"],
        profilePhotoUrl: json?["profilePhotoUrl"],
        coverPhotoUrl: json?["coverPhotoUrl"],
        friendList: friendListJson.length > 0
            ? friendListJson.map((friendId) => friendId.toString()).toList()
            : []);
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "displayName": displayName,
        "signUpTime": signUpTime.toUtc().toIso8601String(),
        "isOnline": isOnline,
        "lastOnline": lastOnline.toUtc().toIso8601String(),
        "about": about,
        "profilePhotoUrl": profilePhotoUrl,
        "coverPhotoUrl": coverPhotoUrl,
        "friendList": friendList,
      };
}
