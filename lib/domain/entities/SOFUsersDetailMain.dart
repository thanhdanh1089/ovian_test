import 'dart:convert';

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
        hasMore: json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "items": sofPost == null
            ? null
            : List<dynamic>.from(sofPost!.map((x) => x.toJson())),
        "has_more": hasMore,
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
        reputationType: json["reputation_history_type"],
        reputationChange: json["reputation_change"],
        postId: json["post_id"],
        creationDate:
            json["creation_date"],
      );

  Map<String, dynamic> toJson() => {
        "reputation_history_type":
            reputationType,
        "reputation_change": reputationChange,
        "post_id": postId,
        "creation_date": creationDate,
      };
}
