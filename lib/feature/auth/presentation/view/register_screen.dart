import 'package:cartzy_app/core/dialogs/app_dialogs.dart';
import 'package:cartzy_app/core/dialogs/app_toasts.dart';
import 'package:cartzy_app/feature/auth/data/repo/repository/auth_repository_impl.dart';
import 'package:cartzy_app/feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cartzy_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:cartzy_app/core/utils/validator_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SignUp",
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
        child: BlocListener<RegisterCubit, RegisterState>(
          bloc: registerCubit,
          listener: (context, state) {
            if (state is RegisterLoading) {
              AppDialogs.showLoadingDialog(context);
            }
            if (state is RegisterError) {
              Navigator.of(context).pop();
              AppToast.showToast(
                context: context,
                title: "Error",
                description: "Error Description",
                type: ToastificationType.error,
              );
            }
            if (state is RegisterSuccess) {
              Navigator.of(context).pop();
              AppToast.showToast(
                context: context,
                title: "Success",
                description: "Done Created Profile",
                type: ToastificationType.success,
              );
              Navigator.of(context).pop();
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Name",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  controller: nameController,
                  validator: Validator.validateName,
                  hintText: "Enter your Name",
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
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
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                TextFormFieldHelper(
                  controller: confirmPasswordController,
                  validator: (value) => Validator.validateConfirmPassword(
                      value, passwordController.text),
                  hintText: "Enter your confirm password",
                  isPassword: true,
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.done,
                ),
                SizedBox(height: 30),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await registerCubit.register(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                  color: Color(0xff212121),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Sign up",
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
                  text: "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff6E6A7C),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
                    },
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pop();
                        },
                      text: "Login",
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

  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late RegisterCubit registerCubit;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    registerCubit = RegisterCubit(injectableAuthRepo());
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
