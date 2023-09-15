import 'package:flutter/material.dart';
import 'package:instagram_clone_app/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Image.asset(
                "assets/instagram_text_logo.png",
                color: primaryColor,
                height: 94,
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
