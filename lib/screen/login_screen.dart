

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhcs/screen/signup_screen.dart';


import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../services/auth/auh_service.dart';
import '../services/auth/auth_exceptions.dart';
import '../utils/colors.dart';
import '../utils/dialogs/error_dialog.dart';
import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

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
              flex: 2,
              child: Container(),
            ),
            Image.asset(
              'assets/logo-cs1.png',
              height: 300,
            ),
            const SizedBox(
              height: 64,
            ),
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Introduce tu correo electrónico',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
                textEditingController: _passController,
                hintText: 'Introduce tu contraseña',
                isPass: true,
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  _isLoading = true;
                });
                final email = _emailController.text;
                final pass = _passController.text;
                try {
                  await AuthService.firebase()
                      .logIn(email: email, password: pass);
                  final user = AuthService.firebase().currentUser;
                  setState(() {
                    _isLoading = false;
                  });

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ResponsiveLayout(
                          webScreenLayout: WebScreenLayout(),
                          mobileScreenLayout: MobileScreenLayout())));
                  // if (user?.isEmailVerified ?? false) {
                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                  //     notesRoute,
                  //     (route) => false,
                  //   );
                  // } else {
                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                  //     verifyEmailRoute,
                  //     (route) => false,
                  //   );
                  // }
                } on UserNotFoundAuthException {
                  await showErrorDialog(context, 'No se encontro el usuario');
                  setState(() {
                    _isLoading = false;
                  });
                } on WrongPasswordAuthException {
                  await showErrorDialog(context, 'Credenciales incorrectas');
                  setState(() {
                    _isLoading = false;
                  });
                } on GenericAuthException {
                  await showErrorDialog(context, 'Authentication error');
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    )),
                    color: blueColor),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text(
                    "Do't have an account?",
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
                  },
                  child: Container(
                    child: const Text(
                      'Sign up.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
