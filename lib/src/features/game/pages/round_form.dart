import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design_system/components/cards/card.dart';
import '../widgets/custom_ratio_field.dart';
import '../widgets/submit_button.dart';
import 'round_header.dart';

class GameRoundPage extends ConsumerWidget {
  const GameRoundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: .min,
        children: [
          Flexible(child: RoundHeader()),
          Card(child: EvaluationRow()),
          SizedBox(height: 24),
          CustomRatioField(),
          SizedBox(height: 24),
          SubmitButton(),
        ],
      ),
    );
  }
}
