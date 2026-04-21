import 'package:http/http.dart' as http;

import '../models/feedback_form_config.dart';
import '../models/feedback_form_kind.dart';

class FormsRepository {
  const FormsRepository();

  Future<void> submitFeedback({
    required FeedbackFormKind kind,
    required String feedbackType,
    required String feedback,
    String? collectionId,
  }) async {
    final config = feedbackFormConfigForKind(kind);
    final cleanFeedbackType = feedbackType.trim();
    final cleanFeedback = feedback.trim();

    if (cleanFeedbackType.isEmpty) {
      throw Exception('A feedback type is required.');
    }
    if (cleanFeedback.isEmpty) {
      throw Exception('Feedback text is required.');
    }

    final body = <String, String>{
      config.feedbackTypeEntryId: cleanFeedbackType,
      config.feedbackEntryId: cleanFeedback,
      'fvv': '1',
      'pageHistory': '0',
      'submissionTimestamp': '-1',
    };

    if (config.collectionEntryId != null) {
      final cleanCollectionId = collectionId?.trim() ?? '';
      if (cleanCollectionId.isEmpty) {
        throw Exception('Collection context is required.');
      }
      body[config.collectionEntryId!] = cleanCollectionId;
    }

    final response = await http.post(
      Uri.parse(config.actionUrl),
      headers: const {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    if (response.statusCode < 200 || response.statusCode >= 400) {
      throw Exception(
        'Google Form submission failed with status ${response.statusCode}.',
      );
    }
  }
}
