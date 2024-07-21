// @dart=2.12
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:me/utility/icon_util.dart';

final IconUtil _iconUtil = IconUtil();

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
      _iconUtil.wavingHand,
    // Further Page
      _iconUtil.flutterLogo,
      _iconUtil.firebaseLogoNew,
      // Icons Social Media
      _iconUtil.imgBrowserDark, // Browser
      _iconUtil.imgBrowserLight,
      _iconUtil.imgGithubDefault, // Github
      _iconUtil.imgGithubDark,
      _iconUtil.imgGithubLight,
      _iconUtil.imgInstagramDefault, // Instagram
      _iconUtil.imgInstagramDark,
      _iconUtil.imgInstagramLight,
      _iconUtil.imgFacebookDefault, // Facebook
      _iconUtil.imgFacebookDark,
      _iconUtil.imgFacebookLight,
      _iconUtil.imgGmailDefault, // Gmail
      _iconUtil.imgGmailDark,
      _iconUtil.imgGmailLight,
      _iconUtil.imgLinkedinDefault, // LijnkedIn
      _iconUtil.imgLinkedinDark,
      _iconUtil.imgLinkedinLight,
      _iconUtil.imgLinkDark, // Link
      _iconUtil.imgLinkLight,
    // Super User Page
    _iconUtil.incognitoMode,
    _iconUtil.incognitoFingerprint,
    _iconUtil.incognitoMask,
  ];

  // Load the image
  preloadedAsset.forEach((imageAsset) async => await loadImage(AssetImage(imageAsset)));
}