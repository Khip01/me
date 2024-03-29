import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:me/service/firebase_auth_services.dart';

class SuperUserPage extends StatefulWidget {
  final User user;
  const SuperUserPage({super.key, required this.user});

  @override
  State<SuperUserPage> createState() => _SuperUserPageState();
}

class _SuperUserPageState extends State<SuperUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Text("Image base64"),
            TextField(),
            Text("Name Project"),
            TextField(),
            Text("Desc Project"),
            TextField(),
            Text("Category"),
            TextField(),
            Text("Creator"),
            TextField(),
            Text("CreatorPhotoProfile"),
            TextField(),
            Text("Date Created"),
            TextField(),
            Text("Link to Github"),
            TextField(),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuthServices.userSignOut();
              },
              child: const Text("Logout kang"),
            ),
          ],
        ),
      ),
    );
  }
}
