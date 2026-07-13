import 'package:flutter/material.dart';
import 'package:goals_app/screens/home/home_screen.dart';
import 'package:goals_app/utils/constants/app_string.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff0057A8),
              Color(0xff2E95D3),
              Color(0xff003B97),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(

            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Column(
                            children: [
                              const Spacer(),

                              // Logo
                              Image.asset(
                                AppString.appLogo,
                                width: 210,
                              ),

                              const SizedBox(height: 70),

                              _emailField(),

                              const SizedBox(height: 22),

                              _passwordField(),

                              const SizedBox(height: 24),

                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ), (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff33D0D9),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),

                              const Spacer(),

                              const Text(
                                "You must have an active subscription with\nGoals to sign in.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 28),

                              const Text(
                                "Version: 3.1.5 (5.0)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),

                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                  ),
              );
            },

          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Email",
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderSide: .none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: .all(16.0),
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderSide: .none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: .all(16.0),
        suffixIcon: TextButton(
          onPressed: () {},
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              color: Color(0xff31AFFF),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}