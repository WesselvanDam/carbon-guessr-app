import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/design_system/app_colors.dart';
import '../../../../shared/design_system/app_typography.dart';
import '../../controllers/game_controller.dart';
import '../../controllers/ratio_controller.dart';
import '../../controllers/timer_controller.dart';

class EvaluationRow extends ConsumerStatefulWidget {
  const EvaluationRow({super.key});

  @override
  ConsumerState<EvaluationRow> createState() => _EvaluationRowState();
}

class _EvaluationRowState extends ConsumerState<EvaluationRow> {
  late final TextEditingController _firstTextController;
  late final TextEditingController _secondTextController;

  @override
  void initState() {
    super.initState();
    final ratio = ref.read(ratioControllerProvider);
    _firstTextController = TextEditingController(
      text: ratio > 1 ? ratio.toStringAsFixed(decimals(ratio)) : '1',
    );
    _secondTextController = TextEditingController(
      text: ratio > 1 ? '1' : (1 / ratio).toStringAsFixed(decimals(1 / ratio)),
    );
  }

  @override
  void dispose() {
    _firstTextController.dispose();
    _secondTextController.dispose();
    super.dispose();
  }

  int decimals(double ratio) {
    if (ratio > 100) return 0;
    if (ratio > 10) return 1;
    return 2;
  }

  void updateControllers(double ratio) {
    // Update the text controllers based on the new ratio

    if (ratio > 1) {
      _firstTextController.text = ratio.toStringAsFixed(decimals(ratio));
      _secondTextController.text = '1';
    } else {
      _firstTextController.text = '1';
      _secondTextController.text = (1 / ratio).toStringAsFixed(
        decimals(1 / ratio),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update the text controllers when the ratio changes
    ref.listen(ratioControllerProvider, (_, next) => updateControllers(next));

    final currentRound = ref.watch(
      gameControllerProvider.select((game) => game.value?.currentRound),
    );

    final isRoundOver = ref.watch(
      timerControllerProvider.select((time) => time == 0),
    );

    final ratio = ref.watch(ratioControllerProvider);

    return Center(
      child: Column(
        children: [
          Text(
            'CURRENT RATIO',
            style: AppTypography.caption.copyWith(color: AppColors.slate400),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.slate200),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  ratio >= 1 ? ratio.toStringAsFixed(decimals(ratio)) : '1',
                  style: AppTypography.h1.copyWith(color: AppColors.primary),
                ),
                Text(
                  ' : ',
                  style: AppTypography.h4.copyWith(
                    color: AppColors.slate300,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  ratio >= 1
                      ? '1'
                      : (1 / ratio).toStringAsFixed(decimals(1 / ratio)),
                  style: AppTypography.h4.copyWith(
                    color: AppColors.slate300,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
