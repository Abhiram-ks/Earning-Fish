import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/features/presentation/bloc/googlesign_bloc/googlesing_bloc.dart';
import 'package:earningfish/features/presentation/widgets/login_widget/login_custom_googlefiled.dart';
import 'package:earningfish/features/presentation/widgets/login_widget/login_state_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCredentialPart extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const LoginCredentialPart({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Or"),
            ),
            Expanded(child: Divider()),
          ],
        ),
       
        ConstantWidgets.hight20(context),
        BlocListener<GooglesignBloc, GooglesignState>(
          listener: (context, loginstate) {
            loginStatehandle(context, loginstate);
          },
          child: CustomGoogleField.googleSignInModule(
            context: context,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            onTap: () {
              context.read<GooglesignBloc>().add(GoogleSignUP());
            },
          ),
        ),

        ConstantWidgets.hight20(context),

        Text.rich(
          TextSpan(
            text:
                "By creating or logging into an account you are agreeing with our",
            style: const TextStyle(fontSize: 12, color: Colors.black54),
            children: [
              TextSpan(
                text: "Terms and Conditions ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              const TextSpan(text: "and "),
              TextSpan(
                text: "Privacy Policy",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        ConstantWidgets.hight20(context),
      ],
    );
  }
}
