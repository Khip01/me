import 'package:flutter_riverpod/flutter_riverpod.dart';

// for any image in listView
final isPreviewMode = StateProvider<int?>(
      (ref) => null,
);

// public varible for history detail page
// (decide wich documentation index should be shown)
final indexDocumentation = StateProvider<int?>(
      (ref) => null,
);