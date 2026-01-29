import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local/custom_ratio_field.dart';
import 'local/submit_button.dart';
import 'round_header.dart';

class GameRoundPage extends ConsumerWidget {
  const GameRoundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        spacing: 24,
        children: [
          RoundHeader(),
          Spacer(),
          CustomRatioField(),
          // Spacer(),
          SubmitButton(),
        ],
      ),
    );
  }
}
