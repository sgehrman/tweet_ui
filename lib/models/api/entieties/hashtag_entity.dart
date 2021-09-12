import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/entity.dart';

/// Represents hashtags which have been parsed out of the Tweet text.
class HashtagEntity extends Entity {
  String text;

  HashtagEntity({
    required this.text,
    required List<int> indices,
  }) : super(indices: indices);

  factory HashtagEntity.fromRawJson(String str) =>
      HashtagEntity.fromJson(json.decode(str));

  factory HashtagEntity.fromJson(Map<String, dynamic> json) => HashtagEntity(
        text: json['text'] == null ? null : json['text'],
        indices: json['indices'] == null
            ? null
            : List<int>.from(json['indices'].map((x) => x)),
      );
}
