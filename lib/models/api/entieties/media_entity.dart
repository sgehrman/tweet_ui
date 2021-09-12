import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/url_entity.dart';

/// Represents media elements uploaded with the Tweet.
class MediaEntity extends UrlEntity {
  /// ID of the media expressed as a 64-bit integer.
  double id;

  /// An https:// URL pointing directly to the uploaded media file, for embedding on https pages.
  /// For media in direct messages, media_url_https must be accessed by signing a request with the user’s access token using OAuth 1.0A.
  /// It is not possible to access images via an authenticated twitter.com session.
  /// Please visit this page to learn how to account for these recent change.
  /// You cannot directly embed these images in a web page.
  /// See Photo Media URL formatting for how to format a photo's URL, such as media_url_https, based on the available sizes.
  String mediaUrlHttps;

  /// Type of uploaded media. Possible types include photo, video, and animated_gif.
  String type;

  /// An object showing available sizes for the media file.
  Sizes? sizes;

  /// Contains information about video.
  VideoInfo? videoInfo;

  MediaEntity({
    required this.id,
    required this.mediaUrlHttps,
    required String url,
    required String displayUrl,
    required String expandedUrl,
    required this.type,
    this.sizes,
    this.videoInfo,
    required List<int> indices,
  }) : super(
            url: url,
            displayUrl: displayUrl,
            expandedUrl: expandedUrl,
            indices: indices);

  factory MediaEntity.fromRawJson(String str) {
    return MediaEntity.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory MediaEntity.fromJson(Map<String, dynamic> json) {
    return MediaEntity(
      id: json['id'] == null ? 0 : json['id'] as double,
      mediaUrlHttps: json['media_url_https'] as String,
      url: json['url'] == null ? '' : json['url'] as String,
      displayUrl:
          json['display_url'] == null ? '' : json['display_url'] as String,
      expandedUrl: json['expanded_url'] as String,
      type: json['type'] == null ? '' : json['type'] as String,
      sizes: json['sizes'] == null
          ? null
          : Sizes.fromJson(Map<String, dynamic>.from(json['sizes'] as Map)),
      videoInfo: json['video_info'] == null
          ? null
          : VideoInfo.fromJson(
              Map<String, dynamic>.from(json['video_info'] as Map)),
      indices: json['indices'] == null
          ? []
          : List<int>.from(json['indices'].map((x) => x) as List),
    );
  }
}

/// All Tweets with native media (photos, video, and GIFs) will include a set of ‘thumb’, ‘small’, ‘medium’, and ‘large’ sizes with height and width pixel sizes.
/// For photos and preview image media URLs, Photo Media URL formatting specifies how to construct different URLs for loading different sized photo media.
class Sizes {
  /// Information for a thumbnail-sized version of the media.
  /// Thumbnail-sized photo media will be limited to fill a 150x150 boundary and cropped.
  Size? thumb;

  /// Information for a small-sized version of the media.
  /// Small-sized photo media will be limited to fit within a 680x680 boundary.
  Size? small;

  /// Information for a medium-sized version of the media.
  /// Medium-sized photo media will be limited to fit within a 1200x1200 boundary.
  Size? medium;

  /// Information for a large-sized version of the media.
  /// Large-sized photo media will be limited to fit within a 2048x2048 boundary.
  Size? large;

  Sizes({
    this.thumb,
    this.small,
    this.large,
    this.medium,
  });

  factory Sizes.fromRawJson(String str) {
    return Sizes.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory Sizes.fromJson(Map<String, dynamic> json) {
    return Sizes(
      thumb: json['thumb'] == null
          ? null
          : Size.fromJson(Map<String, dynamic>.from(json['thumb'] as Map)),
      small: json['small'] == null
          ? null
          : Size.fromJson(Map<String, dynamic>.from(json['small'] as Map)),
      large: json['large'] == null
          ? null
          : Size.fromJson(Map<String, dynamic>.from(json['large'] as Map)),
      medium: json['medium'] == null
          ? null
          : Size.fromJson(Map<String, dynamic>.from(json['medium'] as Map)),
    );
  }
}

class Size {
  /// Width in pixels of this size.
  int w;

  /// Height in pixels of this size.
  int h;

  /// Resizing method used to obtain this size.
  /// A value of fit means that the media was resized to fit one dimension, keeping its native aspect ratio.
  /// A value of crop means that the media was cropped in order to fit a specific resolution.
  String resize;

  Size({
    required this.w,
    required this.h,
    required this.resize,
  });

  factory Size.fromRawJson(String str) {
    return Size.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      w: json['w'] as int,
      h: json['h'] == null ? 0 : json['h'] as int,
      resize: json['resize'] == null ? '' : json['resize'] as String,
    );
  }
}

/// Contains information about video.
class VideoInfo {
  /// The aspect ratio of the video, as a simplified fraction of width and height in a 2-element
  /// list. Typical values are [4, 3] or [16, 9].
  List<int> aspectRatio;

  /// The length of the video, in milliseconds.
  int? durationMillis;

  /// Different encodings/streams of the video.
  List<Variant> variants;

  VideoInfo({
    required this.aspectRatio,
    this.durationMillis,
    required this.variants,
  });

  factory VideoInfo.fromRawJson(String str) {
    return VideoInfo.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      aspectRatio: json['aspect_ratio'] == null
          ? []
          : List<int>.from(json['aspect_ratio'].map((x) => x) as List),
      durationMillis: json['duration_millis'] as int?,
      variants: json['variants'] == null
          ? []
          : List<Variant>.from(
              List<Map<String, dynamic>>.from(json['variants'] as List)
                  .map((x) => Variant.fromJson(x)) as List),
    );
  }
}

class Variant {
  int bitrate;
  String contentType;
  String url;

  Variant({
    required this.bitrate,
    required this.contentType,
    required this.url,
  });

  factory Variant.fromRawJson(String str) {
    return Variant.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      bitrate: json['bitrate'] as int? ?? 0,
      contentType:
          json['content_type'] == null ? '' : json['content_type'] as String,
      url: json['url'] == null ? '' : json['url'] as String,
    );
  }
}
