import 'package:cartzy_app/feature/app_section/app_section.dart';
import 'package:cartzy_app/feature/auth/presentation/view/login_screen.dart';
import 'package:cartzy_app/feature/auth/presentation/view/register_screen.dart';
import 'package:cartzy_app/feature/home/presentation/view/product_details_screen.dart';
import 'package:cartzy_app/feature/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User App",
      initialRoute: AppSection.routeName,
      routes: {
        OnboardingScreen.routeName: (context) => const OnboardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        AppSection.routeName: (context) => const AppSection(),
        ProductDetailsScreen.routeName: (context) =>
            const ProductDetailsScreen(),
      },
    );
  }
}
