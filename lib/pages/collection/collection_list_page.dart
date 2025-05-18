// filepath: c:\Users\wesse\Documents\code\carbon_guessr\code\lib\pages\collection\collection_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/collection/collection_item.dart';
import '../../providers/collection/collection_providers.dart';
import '../../services/navigation/routes.dart';
import '../../utils/string_extensions.dart';
import '../../widgets/collection/collection_switcher.dart';

/// A widget that displays a list of collection items
class CollectionListPage extends ConsumerWidget {
  const CollectionListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the current collection
    final currentCollection = ref.watch(currentCollectionNotifierProvider);

    // Watch the items for the current collection in the selected language
    final collectionItemsAsync =
        ref.watch(allLocalizedCollectionItemsProvider('en-US'));

    return Scaffold(
      appBar: AppBar(
        title: Text('${currentCollection.capitalize()} Collection'),
        actions: const [
          // Add a collection switcher widget
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CollectionSwitcher(
              showLabel: false,
            ),
          ),
        ],
      ),
      body: collectionItemsAsync.when(
        data: (items) => _buildItemList(context, items),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error loading data: $error'),
        ),
      ),
    );
  }

  Widget _buildItemList(BuildContext context, List<CollectionItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.title),
          subtitle: Text(
            '${item.category}: ${item.value}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          onTap: () {
            context.go(
              CollectionDetailRoute(id: item.id.toString()).location,
            );
          },
        );
      },
    );
  }
}
