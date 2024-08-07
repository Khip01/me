// @dart=2.12
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:me/utility/icon_util.dart';

Future<void> loadImage(ImageProvider provider) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: 1,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener((ImageInfo image, bool sync) {
    debugPrint("Image ${image.debugLabel} finished loading");
    completer.complete();
    stream.removeListener(listener);
  }, onError: (dynamic exception, StackTrace? stackTrace) {
    completer.complete();
    stream.removeListener(listener);
    FlutterError.reportError(FlutterErrorDetails(
      context: ErrorDescription('image failed to load'),
      library: 'image resource service',
      exception: exception,
      stack: stackTrace,
      silent: true,
    ));
  });

  stream.addListener(listener);
  return completer.future;
}


// REFERENCE PRELOADING IMAGE ASSET - GITHUB:
// https://github.com/flutter/flutter/issues/26127#issuecomment-782083060


Future<void> preloadIconImage() async {
  // Asset List
  List<String> preloadedAsset = [
    // Welcome Page
      IconUtil.wavingHand,
    // Further Page
      IconUtil.flutterLogo,
      IconUtil.firebaseLogoNew,
      // Icons Social Media
      IconUtil.imgBrowserDark, // Browser
      IconUtil.imgBrowserLight,
      IconUtil.imgGithubDefault, // Github
      IconUtil.imgGithubDark,
      IconUtil.imgGithubLight,
      IconUtil.imgInstagramDefault, // Instagram
      IconUtil.imgInstagramDark,
      IconUtil.imgInstagramLight,
      IconUtil.imgFacebookDefault, // Facebook
      IconUtil.imgFacebookDark,
      IconUtil.imgFacebookLight,
      IconUtil.imgGmailDefault, // Gmail
      IconUtil.imgGmailDark,
      IconUtil.imgGmailLight,
      IconUtil.imgLinkedinDefault, // LijnkedIn
      IconUtil.imgLinkedinDark,
      IconUtil.imgLinkedinLight,
      IconUtil.imgLinkDark, // Link
      IconUtil.imgLinkLight,
    // Super User Page
    // IconUtil.incognitoMode,
    // IconUtil.incognitoFingerprint,
    // IconUtil.incognitoMask,
  ];

  // Load the image
  preloadedAsset.forEach((imageAsset) async => await loadImage(AssetImage(imageAsset)));
}