import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/game/game_service.dart';

part 'game_providers.g.dart';

/// Provider for the GameService
@riverpod
GameService gameService(Ref ref) {
  return GameService();
}
