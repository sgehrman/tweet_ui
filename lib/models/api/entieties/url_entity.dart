import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/entity.dart';

/// Represents URLs included in the text of a Tweet or within textual fields of a user object.
class UrlEntity extends Entity {
  /// Wrapped URL, corresponding to the value embedded directly into the raw Tweet text, and the values for the indices parameter.
  String url;

  /// Expanded version of `` display_url`` .
  String expandedUrl;

  /// URL pasted/typed into Tweet.
  String displayUrl;

  UrlEntity({
    required this.url,
    required this.expandedUrl,
    required this.displayUrl,
    required List<int> indices,
  }) : super(indices: indices);

  factory UrlEntity.fromRawJson(String str) {
    return UrlEntity.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory UrlEntity.fromJson(Map<String, dynamic> json) => UrlEntity(
        url: json['url'] as String,
        expandedUrl:
            json['expanded_url'] == null ? '' : json['expanded_url'] as String,
        displayUrl: json['display_url'] as String,
        indices: json['indices'] == null
            ? []
            : List<int>.from(json['indices'] as List),
      );
}
