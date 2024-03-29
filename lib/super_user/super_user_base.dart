import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/provider/auth_session_provider.dart';
import 'package:me/super_user/super_user.dart';

class SuperUserBase extends ConsumerWidget {
  const SuperUserBase({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var firebaseUser = ref.watch(authSession);

    return firebaseUser.when(
        data: (user) {
          // Will Stream for auth session that user have login
          if (user == null) {
            return const SuperUserLoginPage();
          } else {
            return SuperUserPage(user: user,);
          }
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTree) => SizedBox(
          child: Text("Error Kang :p : $error\n\n$stackTree"),
        ),
    );
  }
}
