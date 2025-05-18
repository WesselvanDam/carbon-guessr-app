import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/collection/collection_providers.dart';
import '../../utils/string_extensions.dart';

/// A widget that allows switching between different collections
class CollectionSwitcher extends ConsumerWidget {
  /// Creates a collection switcher widget
  const CollectionSwitcher({
    this.buttonStyle,
    this.iconSize = 24.0,
    this.showLabel = true,
    super.key,
  });

  /// The button style to use for the switcher button
  final ButtonStyle? buttonStyle;

  /// The size of the icon to display
  final double iconSize;

  /// Whether to show the text label alongside the icon
  final bool showLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCollection = ref.watch(currentCollectionNotifierProvider);

    return FilledButton.tonalIcon(
      style: buttonStyle,
      icon: Icon(Icons.swap_horiz, size: iconSize),
      label: showLabel
          ? Text('${currentCollection.capitalize()} Collection')
          : const SizedBox.shrink(),
      onPressed: () => _showCollectionPicker(context, ref),
    );
  }

  /// Shows a dialog to pick a different collection
  void _showCollectionPicker(BuildContext context, WidgetRef ref) {
    // List of available collections - in a real app, this might come from an API
    final availableCollections = ['carbon', 'energy', 'water', 'waste'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Collection'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: availableCollections.length,
            itemBuilder: (context, index) {
              final collection = availableCollections[index];
              final isSelected =
                  collection == ref.read(currentCollectionNotifierProvider);

              return ListTile(
                title: Text(collection.capitalize()),
                selected: isSelected,
                leading: isSelected
                    ? const Icon(Icons.check_circle)
                    : const Icon(Icons.circle_outlined),
                onTap: () {
                  // Set the new collection
                  ref
                      .read(currentCollectionNotifierProvider.notifier)
                      .setCollection(collection);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
