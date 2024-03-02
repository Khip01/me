import 'package:flutter/material.dart';

class CreationPage extends StatelessWidget {
  const CreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        height: scrHeight,
      ),
    );
  }
}
