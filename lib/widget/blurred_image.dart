import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredImage extends StatelessWidget {
  final String imageAsset;
  final BoxFit fit;

  const BlurredImage({
    super.key,
    required this.imageAsset,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(imageAsset),
          fit: fit,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: const DecoratedBox(decoration: BoxDecoration(color: Colors.transparent)),
      ),
    );
  }
}
