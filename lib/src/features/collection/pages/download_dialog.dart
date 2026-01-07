import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/providers/items.dart';
import '../providers/current_collection.dart';

class DownloadCollectionDialog extends ConsumerWidget {
  const DownloadCollectionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Download Collection'),
      content: const Text(
        'Do you want to download this collection to your local storage for offline access?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            final messenger = ScaffoldMessenger.of(context);
            final navigator = Navigator.of(context);
            ref
                .read(
                  itemsProvider(
                    ref.read(currentCollectionProvider).value!.id,
                  ).notifier,
                )
                .storeRemainingItems()
                .then((result) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text(
                        result is AsyncError
                            ? 'Failed to download collection: ${result.error}'
                            : 'Collection downloaded successfully.',
                      ),
                    ),
                  );
                })
                .then((_) => navigator.pop());
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
