import 'dart:convert';
import 'dart:ffi';

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
        hasMore: json["has_more"] == null ? null : json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "items": sofUsers == null
            ? null
            : List<dynamic>.from(sofUsers!.map((x) => x.toJson())),
        "has_more": hasMore == null ? null : hasMore,
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
    this.isBookmark = false,
  });

  int? userId;
  String? userName;
  String? userAvatar;
  int? reputation;
  String? location;
  int? userAge;
  bool isBookmark;

  factory SOFUser.fromJson(Map<String, dynamic> json) => SOFUser(
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["display_name"] == null ? null : json["display_name"],
        userAvatar:
            json["profile_image"] == null ? null : json["profile_image"],
        reputation: json["reputation"] == null ? null : json["reputation"],
        location: json["location"] == null ? null : json["location"],
        userAge: json["age"] == null ? 0 : json["age"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "display_name": userName == null ? null : userName,
        "profile_image": userAvatar == null ? null : userAvatar,
        "reputation": reputation == null ? null : reputation,
        "location": location == null ? null : location,
        "age": userAge == null ? 0 : userAge,
      };
}

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
