import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/hashtag_entity.dart';
import 'package:tweet_ui/models/api/entieties/media_entity.dart';
import 'package:tweet_ui/models/api/entieties/mention_entity.dart';
import 'package:tweet_ui/models/api/entieties/symbol_entity.dart';
import 'package:tweet_ui/models/api/entieties/url_entity.dart';

/// Provides metadata and additional contextual information about content posted in a tweet.
class TweetEntities {
  /// Represents hashtags which have been parsed out of the Tweet text.
  final List<HashtagEntity> hashtags;

  /// Represents symbols, i.e. $cashtags, included in the text of the Tweet.
  final List<SymbolEntity> symbols;

  /// Represents other Twitter users mentioned in the text of the Tweet.
  final List<MentionEntity> userMentions;

  /// Represents URLs included in the text of a Tweet.
  final List<UrlEntity> urls;

  /// Represents media elements uploaded with the Tweet.
  final List<MediaEntity> media;

  TweetEntities({
    required this.hashtags,
    required this.symbols,
    required this.userMentions,
    required this.urls,
    required this.media,
  });

  const TweetEntities.empty()
      : hashtags = const [],
        symbols = const [],
        userMentions = const [],
        urls = const [],
        media = const [];

  factory TweetEntities.fromRawJson(String str) {
    return TweetEntities.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory TweetEntities.fromJson(Map<String, dynamic> json) {
    return TweetEntities(
      hashtags: json['hashtags'] == null
          ? []
          : List<HashtagEntity>.from(
              List<Map<String, dynamic>>.from(json['hashtags'] as List).map(
                (x) => HashtagEntity.fromJson(x),
              ),
            ),
      symbols: json['symbols'] == null
          ? []
          : List<SymbolEntity>.from(
              List<Map<String, dynamic>>.from(json['symbols'] as List).map(
                (x) => SymbolEntity.fromJson(x),
              ),
            ),
      userMentions: json['user_mentions'] == null
          ? []
          : List<MentionEntity>.from(
              List<Map<String, dynamic>>.from(json['user_mentions'] as List)
                  .map(
                (x) => MentionEntity.fromJson(x),
              ),
            ),
      urls: json['urls'] == null
          ? []
          : List<UrlEntity>.from(
              List<Map<String, dynamic>>.from(json['urls'] as List).map(
                (x) => UrlEntity.fromJson(x),
              ),
            ),
      media: json['media'] == null
          ? []
          : List<MediaEntity>.from(
              List<Map<String, dynamic>>.from(json['media'] as List).map(
                (x) => MediaEntity.fromJson(x),
              ),
            ),
    );
  }
}
