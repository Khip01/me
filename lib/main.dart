import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/app/app.dart';
import 'package:me/shared/helper/helper.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // url strategy remove hashtag # on production flutter web
  // setPathUrlStrategy();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Firebase Init
  // Load All Image Icon
  await preloadIconImage();
  // Load Map Creation
  // final CreationController creationController = CreationController();
  // Map<String, dynamic> resultMap = await creationController.getCreationsMap();
  // setCreationMap(resultMap);
  // final creationsMap = await getDataCreationsJson();
  runApp(ProviderScope(child: MyApp()));
}

