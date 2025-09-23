import 'dart:developer';

import 'package:earningfish/core/common/custom_snackbar.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountHelper {
  static Future<void> deleteAccount(BuildContext context) async {
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      if (user != null) {
        await user.delete();
        await AuthLocalDatasource().clear();
        await GoogleSignIn().signOut();
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      } else {
        CustomSnackBar.show(
          context,
          message: 'No user found to delete.',
          backgroundColor: AppPalette.redColor,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        CustomSnackBar.show(
          context,
          message: 'No user found to delete. $e',
          backgroundColor: AppPalette.redColor,
        );
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.show(
          context,
          message: 'Unexpected erro. $e',
          backgroundColor: AppPalette.redColor,
           textAlign: TextAlign.center
        );
      }
    }
  }
}

Future<void> openWebPage({
  required BuildContext context,
  required String url,
  required String errorMessage,
}) async {
  final Uri uri = Uri.parse(url);
  final bool launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);

  if (!launched) {
    if (context.mounted) {
      CustomSnackBar.show(context, message: errorMessage,backgroundColor: AppPalette.redColor, textAlign: TextAlign.center);
    }
  }
}


