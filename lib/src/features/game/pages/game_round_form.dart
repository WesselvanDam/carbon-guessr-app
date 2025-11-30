import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local/custom_ratio_field.dart';
import 'local/evaluation_row.dart';
import 'local/game_intro.dart';
import 'local/submit_button.dart';

class GameRoundForm extends ConsumerWidget {
  const GameRoundForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          GameIntro(),
          EvaluationRow(),
          CustomRatioField(),
          Align(alignment: Alignment.centerRight, child: SubmitButton()),
        ],
      ),
    );
  }
}
