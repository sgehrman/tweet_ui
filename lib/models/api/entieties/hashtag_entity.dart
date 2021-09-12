import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/entity.dart';

/// Represents hashtags which have been parsed out of the Tweet text.
class HashtagEntity extends Entity {
  String text;

  HashtagEntity({
    required this.text,
    required List<int> indices,
  }) : super(indices: indices);

  factory HashtagEntity.fromRawJson(String str) {
    return HashtagEntity.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory HashtagEntity.fromJson(Map<String, dynamic> json) {
    return HashtagEntity(
      text: json['text'] == null ? '' : json['text']! as String,
      indices: json['indices'] == null
          ? []
          : List<int>.from(json['indices'].map((x) => x) as List),
    );
  }
}
