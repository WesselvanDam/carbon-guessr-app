enum FeedbackFormKind { general, collection }

extension FeedbackFormKindX on FeedbackFormKind {
  String get sheetTitle {
    switch (this) {
      case FeedbackFormKind.general:
        return 'General Feedback';
      case FeedbackFormKind.collection:
        return 'Collection Feedback';
    }
  }

  String get sheetDescription {
    switch (this) {
      case FeedbackFormKind.general:
        return 'Tell us what is working well or what should improve.';
      case FeedbackFormKind.collection:
        return 'Share ideas or corrections for this collection.';
    }
  }
}
