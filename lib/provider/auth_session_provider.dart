import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/service/firebase_auth_services.dart';

final authStreamProvider = Provider<Stream<User?>>((ref) {
  return FirebaseAuthServices.firebaseUserStream;
});

final authSession = StreamProvider<User?>((ref) {
  final firebaseUserStream = ref.watch(authStreamProvider);
  return firebaseUserStream;
});
