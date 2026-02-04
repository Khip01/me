import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class BlurredImage extends StatelessWidget {
  final String imageAsset;
  final String imageAssetHash;
  final BoxFit fit;

  const BlurredImage({
    super.key,
    required this.imageAsset,
    required this.imageAssetHash,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    // WITHOUT HASH FROM BLURHASH
    // return Container(
    //   clipBehavior: Clip.antiAlias,
    //   height: double.maxFinite,
    //   width: double.maxFinite,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: ExactAssetImage(imageAsset),
    //       fit: fit,
    //     ),
    //   ),
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    //     child: const DecoratedBox(decoration: BoxDecoration(color: Colors.transparent)),
    //   ),
    // );
    // WITH HASH FROM BLURHASH
    return Container(
      clipBehavior: Clip.antiAlias,
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: BlurHashImage(
            imageAssetHash,
          ),
          fit: fit,
        ),
      ),
    );
    // return Container(
    //   // clipBehavior: Clip.antiAlias,
    //   height: double.maxFinite,
    //   width: double.maxFinite,
    //   child: Stack(
    //     children: [
    //       Positioned.fill(
    //         child: BlurHash(
    //           hash: imageAssetHash,
    //           image: imageAsset,
    //           imageFit: fit,
    //           color: Colors.transparent,
    //           duration: const Duration(milliseconds: 400),
    //           curve: Curves.easeOutQuart,
    //         ),
    //       ),
    //       Positioned.fill(
    //         child: BackdropFilter(
    //           filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    //           child: const DecoratedBox(decoration: BoxDecoration(color: Colors.transparent)),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
