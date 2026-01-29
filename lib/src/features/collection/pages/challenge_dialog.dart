import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../../design_system/components/chips/info_chip.dart';
import '../../../design_system/components/dialogs/dialog.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_shadows.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../../design_system/components/buttons/action_button.dart';
import '../../game/repository/game_repository.dart';

class ChallengeDialog extends StatefulWidget {
  const ChallengeDialog({required this.startGameCallback, super.key});

  final Function(String) startGameCallback;

  @override
  State<ChallengeDialog> createState() => _ChallengeDialogState();
}

class _ChallengeDialogState extends State<ChallengeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  String? _generatedGameId;

  void _generatePin() {
    setState(() {
      _generatedGameId = GameRepository.newGameId;
    });
    // Copy to clipboard automatically
    Clipboard.setData(ClipboardData(text: _generatedGameId!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PIN copied to clipboard!'),
        backgroundColor: AppColors.green500,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _joinGame() {
    if (_formKey.currentState?.validate() ?? false) {
      final pin = _pinController.text.trim().toUpperCase();
      context.pop();
      widget.startGameCallback(pin);
    }
  }

  void _startGeneratedGame() {
    if (_generatedGameId != null) {
      context.pop();
      widget.startGameCallback(_generatedGameId!);
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            decoration: const BoxDecoration(
              color: AppColors.neutral100,
              border: Border(bottom: BorderSide(color: AppColors.neutral100)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    RoundedIconButton(
                      size: 32,
                      icon: Symbols.close,
                      iconColor: AppColors.neutral400,
                      backgroundColor: AppColors.neutral50,
                      borderColor: AppColors.neutral200,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.accent100, AppColors.accent50],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.accent100),
                    boxShadow: AppShadows.sm,
                  ),
                  child: const Icon(
                    Symbols.groups,
                    size: 32,
                    color: AppColors.accent600,
                    fill: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Challenge Friends',
                  style: AppTypography.h4.copyWith(
                    fontSize: 20,
                    color: AppColors.neutral900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Create a room or join a friend's game to compare scores.",
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.neutral500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Host section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'HOST NEW GAME',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary600,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    InfoChip.primary(label: 'HOST'),
                  ],
                ),
                const SizedBox(height: 8),
                if (_generatedGameId == null)
                  ActionButton.primary(
                    onPressed: _generatePin,
                    label: 'Generate PIN Code',
                    icon: Symbols.vpn_key,
                    fullWidth: true,
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary100),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'YOUR PIN CODE',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _generatedGameId!,
                          style: AppTypography.h2.copyWith(
                            color: AppColors.primary600,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ActionButton.secondary(
                          onPressed: _startGeneratedGame,
                          label: 'Start Game',
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                if (_generatedGameId == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      "You'll get a code to share",
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.neutral400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 24),
                // Divider
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: AppColors.neutral100, thickness: 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.neutral300,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: AppColors.neutral100, thickness: 2),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Join section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'JOIN GAME',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.accent600,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    InfoChip.accent(label: 'PLAYER'),
                  ],
                ),
                const SizedBox(height: 8),
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _pinController,
                          decoration: InputDecoration(
                            hintText: 'PIN CODE',
                            hintStyle: AppTypography.labelLarge.copyWith(
                              color: AppColors.neutral300,
                              letterSpacing: 2,
                            ),
                            errorStyle: AppTypography.bodySmall.copyWith(
                              color: AppColors.accent600,
                            ),
                            filled: true,
                            fillColor: AppColors.neutral50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.neutral200,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.neutral200,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.accent600,
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.neutral900,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 8,
                          buildCounter:
                              (
                                context, {
                                required currentLength,
                                required isFocused,
                                maxLength,
                              }) => null,
                          validator: (value) {
                            if (value == null || value.trim().length != 8) {
                              return 'Enter a valid 8-digit PIN';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      ActionButton.secondary(
                        onPressed: _joinGame,
                        showArrow: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the code from your friend',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.neutral400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
