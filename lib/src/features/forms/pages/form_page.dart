import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../design_system/components/buttons/action_button.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../../design_system/components/form_fields/form_dropdown_field.dart';
import '../../../design_system/components/form_fields/form_text_area_field.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_shadows.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../collection/providers/current_collection.dart';
import '../models/feedback_form_config.dart';
import '../models/feedback_form_kind.dart';
import '../repository/forms_repository.dart';

class FormPage extends ConsumerWidget {
  const FormPage({required this.formKind, super.key});

  final FeedbackFormKind formKind;

  static Future<void> showSheet(
    BuildContext context, {
    required FeedbackFormKind formKind,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FormPage(formKind: formKind),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _FormSheet(formKind: formKind);
  }
}

class _FormSheet extends ConsumerStatefulWidget {
  const _FormSheet({required this.formKind});

  final FeedbackFormKind formKind;

  @override
  ConsumerState<_FormSheet> createState() => _FormSheetState();
}

class _FormSheetState extends ConsumerState<_FormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  final _repository = const FormsRepository();
  String? _selectedFeedbackType;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback({required FeedbackFormConfig config}) async {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid || _selectedFeedbackType == null) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);

    setState(() {
      _isSubmitting = true;
    });

    try {
      String? collectionId;
      if (config.collectionEntryId != null) {
        collectionId = (await ref.read(currentCollectionProvider.future)).id;
      }

      await _repository.submitFeedback(
        kind: widget.formKind,
        feedbackType: _selectedFeedbackType!,
        feedback: _feedbackController.text,
        collectionId: collectionId,
      );

      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Feedback sent. Thank you!'),
          backgroundColor: AppColors.success600,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) {
        return;
      }
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Could not send feedback right now. Please try again.'),
          backgroundColor: AppColors.error600,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = feedbackFormConfigForKind(widget.formKind);
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    final canSubmit = !_isSubmitting;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.9,
            ),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                border: Border(
                  top: BorderSide(color: AppColors.neutral100),
                  left: BorderSide(color: AppColors.neutral100),
                  right: BorderSide(color: AppColors.neutral100),
                ),
                boxShadow: AppShadows.md,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    child: ColoredBox(
                      color: AppColors.neutral50,
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 4,
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: AppColors.neutral200,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.primary100,
                                    ),
                                  ),
                                  child: const Icon(
                                    Symbols.feedback,
                                    color: AppColors.primary700,
                                    fill: 1,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.formKind.sheetTitle,
                                        style: AppTypography.h4.copyWith(
                                          color: AppColors.neutral900,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        widget.formKind.sheetDescription,
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.neutral500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RoundedIconButton(
                                  size: 32,
                                  iconSize: 20,
                                  icon: Symbols.close,
                                  backgroundColor: AppColors.neutral50,
                                  borderColor: AppColors.neutral200,
                                  iconColor: AppColors.neutral500,
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.neutral100),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FormDropdownField(
                              label: 'Type of feedback',
                              value: _selectedFeedbackType,
                              options: config.feedbackTypeOptions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedFeedbackType = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a feedback type.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            FormTextAreaField(
                              label: 'Feedback',
                              controller: _feedbackController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please share your feedback.';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                widget.formKind == FeedbackFormKind.collection
                                    ? 'Collection details are attached automatically.'
                                    : 'Collection-specific feedback? Please use the form at the bottom of the collection page.',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.neutral500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ActionButton.primary(
                              onPressed: canSubmit
                                  ? () => _submitFeedback(config: config)
                                  : null,
                              label: _isSubmitting
                                  ? 'Sending...'
                                  : 'Send Feedback',
                              icon: Symbols.send,
                              fullWidth: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
