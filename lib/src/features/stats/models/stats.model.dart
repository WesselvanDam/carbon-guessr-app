import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats.model.freezed.dart';
part 'stats.model.g.dart';

@freezed
abstract class StatsModel with _$StatsModel {
  const factory StatsModel({
    @Default(0) int gamesFinished,
    @Default([]) List<int> recentGameScores,
    int? highScore,
  }) = _StatsModel;
  const StatsModel._();

  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      _$StatsModelFromJson(json);

  int? get averageScore {
    if (recentGameScores.isEmpty) return null;

    final total = recentGameScores.reduce((a, b) => a + b);
    return (total / recentGameScores.length).round();
  }
}
