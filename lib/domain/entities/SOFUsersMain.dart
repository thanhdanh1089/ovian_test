import 'dart:convert';

SOFUsersMain sofUsersMainFromJson(String str) =>
    SOFUsersMain.fromJson(json.decode(str));

String sofUsersMainToJson(SOFUsersMain data) => json.encode(data.toJson());

class SOFUsersMain {
  SOFUsersMain({
    this.sofUsers,
    this.hasMore,
  });

  List<SOFUser>? sofUsers;
  bool? hasMore;

  factory SOFUsersMain.fromJson(Map<String, dynamic> json) => SOFUsersMain(
        sofUsers: json["items"] == null
            ? null
            : List<SOFUser>.from(json["items"].map((x) => SOFUser.fromJson(x))),
        hasMore: json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "items": sofUsers == null
            ? null
            : List<dynamic>.from(sofUsers!.map((x) => x.toJson())),
        "has_more": hasMore,
      };
}

class SOFUser {
  SOFUser({
    this.userId,
    this.userName,
    this.userAvatar,
    this.reputation,
    this.location,
    this.userAge,
    this.isBookmark,
  });

  int? userId;
  String? userName;
  String? userAvatar;
  int? reputation;
  String? location;
  int? userAge;
  bool? isBookmark;

  factory SOFUser.fromJson(Map<String, dynamic> json) => SOFUser(
        userId: json["user_id"] ?? 0,
        userName: json["display_name"] ?? "",
        userAvatar:
            json["profile_image"] ?? "",
        reputation: json["reputation"] ?? "",
        location: json["location"] ?? "",
        userAge: json["age"] ?? 0,
        isBookmark: false,
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId ?? userId,
        "display_name": userName ?? "",
        "profile_image": userAvatar ?? "",
        "reputation": reputation ?? "",
        "location": location ?? "",
        "age": userAge ?? 0,
      };
}