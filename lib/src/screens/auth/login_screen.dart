import 'package:chat_app_flutter/src/screens/auth/sign_up_screen.dart';
import 'package:chat_app_flutter/src/screens/main/home_screen.dart';
import 'package:chat_app_flutter/src/services/service.dart';
import 'package:chat_app_flutter/src/widgets/custom_button.dart';
import 'package:chat_app_flutter/src/widgets/field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            )
          : Column(
              children: [
                SizedBox(height: size.height / 10),
                SizedBox(
                  width: size.width / 1.3,
                  child: const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width / 1.3,
                  child: const Text(
                    "Sign In to Continue!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: size.height / 10),
                Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: Field(
                    size: size,
                    hintText: "email",
                    icon: Icons.account_box,
                    controller: _email,
                    isPassword: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: Field(
                      size: size,
                      hintText: "password",
                      icon: Icons.lock,
                      controller: _password,
                      isPassword: true,
                    ),
                  ),
                ),
                SizedBox(height: size.height / 10),
                CustomButton(
                  size: size,
                  text: "Login",
                  onTap: () {
                    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      login(_email.text, _password.text).then((user) {
                        if (user != null) {
                          setState(() {
                            isLoading = false;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ));
                          });
                        }
                      });
                    }
                  },
                ),
                SizedBox(height: size.height / 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
