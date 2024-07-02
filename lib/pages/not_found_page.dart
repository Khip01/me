import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              const Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Center(
                  child: Text("Oops, Sorry page not found!")
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.goNamed("welcome");
                    },
                    child: const Text("Go to Welcome Page"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
