import 'package:cartzy_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:cartzy_app/core/dialogs/app_dialogs.dart';
import 'package:cartzy_app/core/dialogs/app_toasts.dart';
import 'package:cartzy_app/core/utils/validator_functions.dart';
import 'package:cartzy_app/feature/app_section/app_section.dart';
import 'package:cartzy_app/feature/auth/data/repo/repository/auth_repository_impl.dart';
import 'package:cartzy_app/feature/auth/presentation/view/register_screen.dart';
import 'package:cartzy_app/feature/auth/presentation/view_model/login/login_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late LoginCubit cubit;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    cubit = LoginCubit(injectableAuthRepo());

    _loadSavedCredentialsAndLogin();
  }

  Future<void> _loadSavedCredentialsAndLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      cubit.login(
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff1F1F1F),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: BlocListener<LoginCubit, LoginState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is LoginLoading) {
                AppDialogs.showLoadingDialog(context);
              }
              if (state is LoginError) {
                Navigator.of(context).pop();
                AppToast.showToast(
                  context: context,
                  title: "Error",
                  description: "Error Form Api",
                  type: ToastificationType.error,
                );
              }
              if (state is LoginSuccess) {
                Navigator.of(context).pop();
                AppToast.showToast(
                  context: context,
                  title: "Success",
                  description: "Login Success",
                  type: ToastificationType.success,
                );
                Navigator.of(context)
                    .pushReplacementNamed(AppSection.routeName);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  controller: emailController,
                  validator: Validator.validateEmail,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  controller: passwordController,
                  validator: Validator.validatePassword,
                  hintText: "Enter your password",
                  isPassword: true,
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                SizedBox(height: 30),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await cubit.login(
                          emailController.text, passwordController.text);
                    }
                  },
                  color: Color(0xff212121),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff6E6A7C),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        },
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
