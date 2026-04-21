import 'feedback_form_kind.dart';

class FeedbackFormConfig {
  const FeedbackFormConfig({
    required this.kind,
    required this.formId,
    required this.actionUrl,
    required this.feedbackTypeEntryId,
    required this.feedbackEntryId,
    required this.feedbackTypeOptions,
    this.collectionEntryId,
  });

  final FeedbackFormKind kind;
  final String formId;
  final String actionUrl;
  final String feedbackTypeEntryId;
  final String feedbackEntryId;
  final String? collectionEntryId;
  final List<String> feedbackTypeOptions;
}

const generalFeedbackFormConfig = FeedbackFormConfig(
  kind: FeedbackFormKind.general,
  formId: '1FAIpQLSersvTHLltSB53bYPYimuxdZ389g_B0a3uECvj2ezSxGrM65A',
  actionUrl:
      'https://docs.google.com/forms/d/e/1FAIpQLSersvTHLltSB53bYPYimuxdZ389g_B0a3uECvj2ezSxGrM65A/formResponse',
  feedbackTypeEntryId: 'entry.622513774',
  feedbackEntryId: 'entry.2086140268',
  feedbackTypeOptions: [
    'Report a bug',
    'Propose a new collection',
    'Propose a new feature',
    'Something else',
  ],
);

const collectionFeedbackFormConfig = FeedbackFormConfig(
  kind: FeedbackFormKind.collection,
  formId: '1FAIpQLScIS3aZZcMNnza3C-wbj8diQ6cgZwHhI-MrXDXyiq40BYV4qQ',
  actionUrl:
      'https://docs.google.com/forms/d/e/1FAIpQLScIS3aZZcMNnza3C-wbj8diQ6cgZwHhI-MrXDXyiq40BYV4qQ/formResponse',
  collectionEntryId: 'entry.202024308',
  feedbackTypeEntryId: 'entry.105463886',
  feedbackEntryId: 'entry.197726248',
  feedbackTypeOptions: [
    'Propose a new item',
    'Propose a correction',
    'Something else',
  ],
);

FeedbackFormConfig feedbackFormConfigForKind(FeedbackFormKind kind) {
  switch (kind) {
    case FeedbackFormKind.general:
      return generalFeedbackFormConfig;
    case FeedbackFormKind.collection:
      return collectionFeedbackFormConfig;
  }
}
