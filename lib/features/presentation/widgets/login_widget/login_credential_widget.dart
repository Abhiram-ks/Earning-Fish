import 'package:earningfish/core/accont_helper/account_helper.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/features/presentation/bloc/googlesign_bloc/googlesing_bloc.dart';
import 'package:earningfish/features/presentation/widgets/login_widget/login_custom_googlefiled.dart';
import 'package:earningfish/features/presentation/widgets/login_widget/login_state_handle.dart';
import 'package:flutter/gestures.dart';
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

        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
                  "By creating or logging into an account you are agreeing with our ",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
              
              children: [
                TextSpan(
                  text: "Terms and Conditions",
                  style: TextStyle(
                    color: Colors.blue[700],
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          openWebPage(
                            context: context,
                            url:
                                'https://www.freeprivacypolicy.com/live/b1f699a5-4a9a-463a-9330-ba87259e8ab2',
                            errorMessage: 'Could not open Terms & Conditions',
                          );
                        },
                ),
                const TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(
                    color: Colors.blue[700],
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          openWebPage(
                            context: context,
                            url:
                                'https://www.freeprivacypolicy.com/live/39a41746-267a-4ac3-b926-971da3bdf7bc',
                            errorMessage: 'Could not open Privacy Policy',
                          );
                        },
                ),
              ],
            ),
          ),
        ),
        ConstantWidgets.hight20(context),
      ],
    );
  }
}
