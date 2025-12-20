import 'package:cartzy_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:cartzy_app/feature/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late String name;
  late String email;
  late String password;
  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFF2F2F2),
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            bool isLoading = state is ProfileLoading;
            if (state is ProfileError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
            var profile = context.read<ProfileCubit>().user;
            if (profile != null && !isChanged) {
              name = profile.name;
              email = profile.email;
              password = profile.password;
              nameController.text = name;
              emailController.text = email;
              passwordController.text = password;
            }
            return Skeletonizer(
              enabled: isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    /// Avatar
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: profile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    profile.avatar,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// Name
                    _label('Name'),
                    TextFormFieldHelper(
                      onChanged: (value) {
                        onChanged();
                      },
                      controller: nameController,
                      hintText: profile?.name ?? 'Mohamed',
                    ),

                    const SizedBox(height: 20),

                    /// Email
                    _label('Email'),
                    TextFormFieldHelper(
                      onChanged: (value) {
                        onChanged();
                      },
                      controller: emailController,
                      hintText: profile?.email ?? 'BtHb7@example.com',
                    ),

                    const SizedBox(height: 20),

                    /// Password
                    _label('Password'),
                    TextFormFieldHelper(
                      onChanged: (value) {
                        onChanged();
                      },
                      controller: passwordController,
                      hintText: profile?.password ?? '********',
                      isPassword: true,
                    ),

                    const SizedBox(height: 40),

                    /// Submit Button
                    isChanged
                        ? SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onChanged() {
    if (nameController.text != name ||
        emailController.text != email ||
        passwordController.text != password) {
      isChanged = true;
      setState(() {});
    } else {
      isChanged = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
