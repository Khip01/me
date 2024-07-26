import 'package:flutter_riverpod/flutter_riverpod.dart';

// public varible for history detail page
// (decide wich documentation index should be shown)
final indexDocumentation = StateProvider<int?>(
      (ref) => null,
);