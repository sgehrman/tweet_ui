import 'dart:convert';

/// Users can be anyone or anything. They tweet, follow, create lists, have a home_timeline, can be
/// mentioned, and can be looked up in bulk.
class User {
  /// The integer representation of the unique identifier for this User.
  /// This number is greater than 53 bits and some programming languages may have difficulty/silent defects in interpreting it.
  /// Using a signed 64 bit integer for storing this identifier is safe.
  /// Use id_str for fetching the identifier to stay on the safe side. See Twitter IDs, JSON and Snowflake .
  double id;

  /// The name of the user, as they’ve defined it. Not necessarily a person’s name.
  /// Typically capped at 50 characters, but subject to change.
  String name;

  /// The screen name, handle, or alias that this user identifies themselves with.
  /// screen_names are unique but subject to change. Use id_str as a user identifier whenever possible.
  /// Typically a maximum of 15 characters long, but some historical accounts may exist with longer names.
  String screenName;

  /// A HTTPS-based URL pointing to the user’s profile image.
  String? profileImageUrlHttps;

  /// When true, indicates that the user has a verified account. See Verified Accounts
  bool verified;

  User({
    required this.id,
    required this.name,
    required this.screenName,
    required this.verified,
    this.profileImageUrlHttps,
  });

  factory User.fromRawJson(String str) {
    return User.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] == null ? 0 : json['id'] as double,
        name: json['name'] == null ? '' : json['name'] as String,
        screenName:
            json['screen_name'] == null ? '' : json['screen_name'] as String,
        verified: json['verified'] as bool,
        profileImageUrlHttps: json['profile_image_url_https'] == null
            ? null
            : json['profile_image_url_https'] as String,
      );
}
