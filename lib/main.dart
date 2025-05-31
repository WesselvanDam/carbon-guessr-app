import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'i18n/strings.g.dart';
import 'utils/providerObserver.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    observers: [
      // Add your custom provider observer here
      RiverpodProviderObserver(),
    ],
    child: TranslationProvider(child: const App()),
  ));
}
