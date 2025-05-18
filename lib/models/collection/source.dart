import 'package:freezed_annotation/freezed_annotation.dart';

part 'source.freezed.dart';
part 'source.g.dart';

/// Model representing a citation source for collection items
@freezed
abstract class Source with _$Source {
  const factory Source({
    required int id,
    required String title,
    required String mla,
    required String url,
    required List<int> citedBy,
  }) = _Source;

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
}
