import 'dart:convert';
import 'dart:ffi';

SOFUsersMain sofUsersMainFromJson(String str) => SOFUsersMain.fromJson(json.decode(str));

String sofUsersMainToJson(SOFUsersMain data) => json.encode(data.toJson());

class SOFUsersMain {
  SOFUsersMain({
    this.sofUsers,
  });

  List<SOFUser>? sofUsers;

  factory SOFUsersMain.fromJson(Map<String, dynamic> json) => SOFUsersMain(
    sofUsers: json["items"] == null ? null : List<SOFUser>.from(json["items"].map((x) => SOFUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": sofUsers == null ? null : List<dynamic>.from(sofUsers!.map((x) => x.toJson())),
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
  });

  int? userId;
  String? userName;
  String? userAvatar;
  int? reputation;
  String? location;
  int? userAge;

  factory SOFUser.fromJson(Map<String, dynamic> json) => SOFUser(
    userId: json["user_id"] == null ? null : json["user_id"],
    userName: json["display_name"] == null ? null : json["display_name"],
    userAvatar: json["profile_image"] == null ? null : json["profile_image"],
    reputation: json["reputation"] == null ? null : json["reputation"],
    location: json["location"] == null ? null : json["location"],
    userAge: json["age"] == null ? null : json["age"],
  );

  Map<String, dynamic> toJson() => {
    "account_id": userId == null ? null : userId,
    "display_name": userName == null ? null : userName,
    "profile_image": userAvatar == null ? null : userAvatar,
    "reputation": reputation == null ? null : reputation,
    "location": location == null ? null : location,
    "age": userAge == null ? null : userAge,
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