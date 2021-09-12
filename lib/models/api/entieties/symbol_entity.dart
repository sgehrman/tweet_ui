import 'dart:convert';

import 'package:tweet_ui/models/api/entieties/entity.dart';

/// Represents symbols which have been parsed out of the Tweet text.
class SymbolEntity extends Entity {
  /// Name of the cashhtag, minus the leading ‘$’ character.
  String text;

  SymbolEntity({
    required this.text,
    required List<int> indices,
  }) : super(indices: indices);

  factory SymbolEntity.fromRawJson(String str) {
    return SymbolEntity.fromJson(
      Map<String, dynamic>.from(json.decode(str) as Map),
    );
  }

  factory SymbolEntity.fromJson(Map<String, dynamic> json) {
    return SymbolEntity(
      text: json['text'],
      indices: json['indices'] == null
          ? null
          : List<int>.from(json['indices'].map((x) => x)),
    );
  }
}
