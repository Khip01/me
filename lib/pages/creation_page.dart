import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';

class CreationPage extends ConsumerWidget {
  const CreationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        height: scrHeight,
        color: (ref.watch(isDarkMode) ? styleUtil.c_33 : styleUtil.c_255),
      ),
    );
  }
}
