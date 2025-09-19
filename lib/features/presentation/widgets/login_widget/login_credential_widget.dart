import 'package:earningfish/core/common/custom_button.dart';
import 'package:earningfish/core/common/custom_snackbar.dart';
import 'package:earningfish/core/common/custom_textfiled.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/core/validation/validation_helper.dart';
import 'package:earningfish/features/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:earningfish/features/presentation/widgets/login_widget/login_state_handle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCredentialPart extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  const LoginCredentialPart({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  State<LoginCredentialPart> createState() => _LoginCredentialPartState();
}

class _LoginCredentialPartState extends State<LoginCredentialPart> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emainController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: 'Email *',
            hintText: 'Enter valid email ?',
            prefixIcon: CupertinoIcons.mail_solid,
            controller: _emainController,
            validate: ValidatorHelper.validateEmailId,
          ),
          TextFormFieldWidget(
            label: 'Password *',
            hintText: 'Enter Password',
            prefixIcon: CupertinoIcons.lock,
            controller: _passwordController,
            validate: ValidatorHelper.loginValidation,
            isPasswordField: true,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.lock_clock_outlined,
                size: 18,
                color: AppPalette.blueColor,
              ),
              ConstantWidgets.width20(context),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Authenticate account ?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppPalette.blueColor,
                  ),
                ),
              ),
            ],
          ),
          ConstantWidgets.hight10(context),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
             loginStateHandle(context, state);
            },
            child: CustomButton(
              text: "Log in",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginRequest(email: _emainController.text.trim(), password: _passwordController.text.trim()));
                } else {
                  CustomSnackBar.show(
                    context,
                    message:"Please fill the necessary details, then proceed to the next step.",
                    backgroundColor: AppPalette.redColor,
                    textAlign: TextAlign.center
                  );
                }
              },
            ),
          ),
          ConstantWidgets.hight10(context),
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

          ConstantWidgets.hight10(context),

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
          ConstantWidgets.hight10(context),
        ],
      ),
    );
  }
}
