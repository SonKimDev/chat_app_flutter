import 'package:chat_app_flutter/src/services/service.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height / 50),
                  SizedBox(
                    width: size.width / 1.3,
                    child: const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 1.3,
                    child: const Text(
                      "Sign Up to Continue!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: Field(
                        size: size,
                        hintText: "Name",
                        icon: Icons.account_box,
                        controller: _name,
                        isPassword: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: Field(
                        size: size,
                        hintText: "email",
                        icon: Icons.email,
                        controller: _email,
                        isPassword: false,
                      ),
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
                  SizedBox(height: size.height / 20),
                  CustomButton(
                    size: size,
                    text: "Sign Up",
                    onTap: () {
                      if (_name.text.isNotEmpty &&
                          _email.text.isNotEmpty &&
                          _password.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        createAccount(_name.text, _email.text, _password.text)
                            .then((user) {
                          if (user != null) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      }
                    },
                  ),
                  SizedBox(height: size.height / 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have account?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
