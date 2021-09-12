import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/entity.dart';

/// Represents other Twitter users mentioned in the text of the Tweet.
class MentionEntity extends Entity {
  /// Screen name of the referenced user.
  String screenName;

  MentionEntity({
    required this.screenName,
    required List<int> indices,
  }) : super(indices: indices);

  factory MentionEntity.fromRawJson(String str) {
    return MentionEntity.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory MentionEntity.fromJson(Map<String, dynamic> json) {
    return MentionEntity(
      screenName:
          json['screen_name'] == null ? '' : json['screen_name'] as String,
      indices: json['indices'] == null
          ? []
          : List<int>.from(json['indices'] as List),
    );
  }
}
