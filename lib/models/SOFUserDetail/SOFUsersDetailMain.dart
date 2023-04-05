import 'dart:convert';
import 'dart:ffi';

SOFUsersDetailMain sofUsersMainFromJson(String str) =>
    SOFUsersDetailMain.fromJson(json.decode(str));

String sofUsersMainToJson(SOFUsersDetailMain data) =>
    json.encode(data.toJson());

class SOFUsersDetailMain {
  SOFUsersDetailMain({
    this.sofPost,
    this.hasMore,
  });

  List<SOFPost>? sofPost;
  bool? hasMore;

  factory SOFUsersDetailMain.fromJson(Map<String, dynamic> json) =>
      SOFUsersDetailMain(
        sofPost: json["items"] == null
            ? null
            : List<SOFPost>.from(json["items"].map((x) => SOFPost.fromJson(x))),
        hasMore: json["has_more"] == null ? null : json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "items": sofPost == null
            ? null
            : List<dynamic>.from(sofPost!.map((x) => x.toJson())),
        "has_more": hasMore == null ? null : hasMore,
      };
}

class SOFPost {
  SOFPost({
    this.reputationType,
    this.reputationChange,
    this.postId,
    this.creationDate,
  });

  String? reputationType;
  int? reputationChange;
  int? postId;
  int? creationDate;

  factory SOFPost.fromJson(Map<String, dynamic> json) => SOFPost(
        reputationType: json["reputation_history_type"] == null
            ? null
            : json["reputation_history_type"],
        reputationChange: json["reputation_change"] == null
            ? null
            : json["reputation_change"],
        postId: json["post_id"] == null ? null : json["post_id"],
        creationDate:
            json["creation_date"] == null ? null : json["creation_date"],
      );

  Map<String, dynamic> toJson() => {
        "reputation_history_type":
            reputationType == null ? null : reputationType,
        "reputation_change": reputationChange == null ? null : reputationChange,
        "post_id": postId == null ? null : postId,
        "creation_date": creationDate == null ? null : creationDate,
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
