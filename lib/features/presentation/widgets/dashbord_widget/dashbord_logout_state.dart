
import 'package:earningfish/core/common/custom_snackbar.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/logout_bloc/logout_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void logoutStateHandle(BuildContext context, LogoutState state) {

  if (state is LogoutSuccess) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  } else if (state is LogoutAlertState) {
    showCupertinoDialog(
      context: context,
      builder:
          (dialogContext) => CupertinoAlertDialog(
            title: Text('Session Logout'),
            content: Text(
              'Are you sure you want to log out? ',
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Yes, Logout',
                  style: TextStyle(color: AppPalette.redColor),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                 context.read<LogoutBloc>().add(LogoutProceed());
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Cancel',style: TextStyle(color: AppPalette.blackColor),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  } 
  else if (state is LogoutFailure) {
    CustomSnackBar.show(
      context,
      message: 'Exception error occurred: ${state.message}',
      backgroundColor: AppPalette.redColor,
      textAlign: TextAlign.center
    );
  }
}
