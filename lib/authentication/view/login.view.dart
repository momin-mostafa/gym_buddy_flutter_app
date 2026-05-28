import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gym_buddy/authentication/auth.service.dart';
import 'package:gym_buddy/authentication/view_model/auth.vm.dart';
import 'package:gym_buddy/main.dart';
import 'package:gym_buddy/splash/water_background.dart';
import 'package:provider/provider.dart';

import '../../user_interaction_tracker.dart' show UserInteractionTracker;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isSignUp = false;

  bool obscurePassword = true;

  @override
  void initState() {
    UserInteractionTracker().onScreen("LoginView");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  final spacing = 16.0;

  Widget get helperTextWidget {
    final text = isSignUp
        ? "Already have an account ? "
        : "Don't have an account already ?";
    return Column(
      children: [
        SizedBox(height: 10),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: spacing,
          children: [
            Container(
                  clipBehavior: Clip.hardEdge,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Stack(
                    children: [
                      Transform.flip(
                        flipX: true,
                        child: WaterShaderBackground(),
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              // white,
                              white.withAlpha(0),
                              white.withAlpha(10),
                              white.withAlpha(80),
                              white.withAlpha(180),
                              white.withAlpha(200),
                              white.withAlpha(230),
                              // white.withAlpha(180),
                              white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .moveY(begin: 100, end: 0, duration: 450.ms)
                .fadeOut(duration: 450.ms, delay: 5.seconds),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: spacing,
                  children: [
                    Text(
                      "Login or Sign Up",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "********@*****.com",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        // return 'Please enter proper email address';
                        return null;
                      },
                      autofocus: true,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "*****",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: obscurePassword
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Column(
              spacing: spacing,
              children: [
                helperTextWidget,
                TextButton(
                  onPressed: () => setState(() {
                    isSignUp = !isSignUp;
                    UserInteractionTracker().buttonClick(
                      buttonName,
                      properties: {'email': email.text},
                    );
                    print(SupabaseAuthService().isUserAuthenticated);
                  }),
                  child: Text(buttonName),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isSignUp
            ? () async {
                if (!_formKey.currentState!.validate()) return;
                UserInteractionTracker().buttonClick(
                  "Sign Up FAB",
                  properties: {"email": email.text},
                );
                await context.read<AuthVM>().signUpWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );
              }
            : () async {
                if (!_formKey.currentState!.validate()) return;
                UserInteractionTracker().buttonClick(
                  "Sign In FAB",
                  properties: {"email": email.text},
                );
                await context.read<AuthVM>().signInWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );
              },
        child: isSignUp ? Icon(Icons.arrow_forward) : Text("Login"),
      ),
    );
  }

  String get buttonName => isSignUp ? "Login" : " Sign up";
}
