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
    return Column(
      children: [
        // Top section with intro and current ratio
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              GameIntro(),
              SizedBox(height: 24),
              EvaluationRow(),
            ],
          ),
        ),
        // Custom ratio field (full width)
        const Expanded(
          child: CustomRatioField(),
        ),
        // Bottom section with submit button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
            child: const SubmitButton(),
          ),
        ),
      ],
    );
  }
}
