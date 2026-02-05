import 'package:flutter/material.dart';
import 'package:me/app/theme/style_util.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUrlWithSnackbar {
  final BuildContext context;

  OpenUrlWithSnackbar(this.context);

  // --- Content Body Section ---
  // Open Url
  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    !await launchUrl(uri);
  }

  // Show Snackbar Template
  Future<void> openUrl({
    required String url,
    required String snackbarMessage,
    required bool isDarkMode,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 30),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 5,
              color: (isDarkMode)
                  ? StyleUtil.c_success_dark
                  : StyleUtil.c_success_light,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 14.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: StyleUtil.c_255,
                      ),
                    ),
                    Text(
                      snackbarMessage,
                      style: StyleUtil.text_small_Medium.copyWith(
                        letterSpacing: 1,
                        color: StyleUtil.c_255,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    await _launchUrl(url);
  }
}
