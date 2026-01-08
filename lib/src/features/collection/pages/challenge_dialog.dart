import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../shared/design_system/app_colors.dart';
import '../../../shared/design_system/app_shadows.dart';
import '../../../shared/design_system/app_typography.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/buttons/secondary_button.dart';
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
      SnackBar(
        content: const Text('PIN copied to clipboard!'),
        backgroundColor: AppColors.green500,
        duration: const Duration(seconds: 2),
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
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 40,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              decoration: const BoxDecoration(
                color: AppColors.slate50,
                border: Border(
                  bottom: BorderSide(color: AppColors.slate100),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () => context.pop(),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.slate200),
                          ),
                          child: const Icon(
                            Symbols.close,
                            size: 18,
                            color: AppColors.slate400,
                          ),
                        ),
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
                        colors: [AppColors.orange100, AppColors.orange50],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.orange100),
                      boxShadow: AppShadows.sm,
                    ),
                    child: const Icon(
                      Symbols.groups,
                      size: 32,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Challenge Friends',
                    style: AppTypography.h4.copyWith(
                      fontSize: 20,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Create a room or join a friend\'s game to compare scores.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.slate500,
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
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'LEADER',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_generatedGameId == null)
                    PrimaryButton(
                      onPressed: _generatePin,
                      label: 'Generate PIN Code',
                      icon: Symbols.vpn_key,
                      fullWidth: true,
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.blue50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.blue100),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'YOUR PIN CODE',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _generatedGameId!,
                            style: AppTypography.h2.copyWith(
                              color: AppColors.primary,
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          PrimaryButton(
                            onPressed: _startGeneratedGame,
                            label: 'Start Game',
                            fullWidth: true,
                          ),
                        ],
                      ),
                    ),
                  if (_generatedGameId == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'You\'ll get a code to share',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.slate400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 24),
                  // Divider
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: AppColors.slate100,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.slate300,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: AppColors.slate100,
                          thickness: 2,
                        ),
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
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.orange100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'PLAYER',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.secondary,
                            fontSize: 9,
                          ),
                        ),
                      ),
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
                                color: AppColors.slate300,
                                letterSpacing: 2,
                              ),
                              filled: true,
                              fillColor: AppColors.slate50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.slate200,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.slate200,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.secondary,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.text,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 8,
                            buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                            validator: (value) {
                              if (value == null || value.trim().length != 8) {
                                return 'Enter a valid 8-digit PIN';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTapDown: (_) => setState(() {}),
                          onTapUp: (_) {
                            setState(() {});
                            _joinGame();
                          },
                          onTapCancel: () => setState(() {}),
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: AppShadows.gameBtnSecondary,
                            ),
                            child: const Icon(
                              Symbols.arrow_forward,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the code from your friend',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.slate400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
