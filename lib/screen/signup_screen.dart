import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../services/auth/auh_service.dart';
import '../services/auth/auth_exceptions.dart';
import '../utils/colors.dart';
import '../utils/dialogs/error_dialog.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    dynamic im = await pickImage(ImageSource.gallery);
    if (im is bool) {
      showErrorDialog(context, 'No image selected');
    }
    if (im is Uint8List) {
      setState(() {
        _image = im;
      });
    }
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
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
                textEditingController: _userNameController,
                hintText: 'Entra tu nombre',
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Entra tu Correo Electrónico',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
                textEditingController: _passController,
                hintText: 'Entra tu contraseña',
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
                final username = _userNameController.text;
                try {
                  await AuthService.firebase().createUser(
                      email: email,
                      password: pass,
                      username: username,);

                  await AuthService.firebase().sendEmailVerification();
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ResponsiveLayout(
                          webScreenLayout: WebScreenLayout(),
                          mobileScreenLayout: MobileScreenLayout())));
                  //  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  await showErrorDialog(context, 'Weak pass');
                  setState(() {
                    _isLoading = false;
                  });
                } on EmailAlredyInUseAuthException {
                  await showErrorDialog(context, 'Email is alredy in use');
                  setState(() {
                    _isLoading = false;
                  });
                } on InvalidEmailAuthException {
                  await showErrorDialog(context, 'Invalid Email');
                  setState(() {
                    _isLoading = false;
                  });
                } on GenericAuthException {
                  await showErrorDialog(context, 'Register error');
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
                    : const Text('Sign up'),
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
              flex: 2,
              child: Container(),
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
                        builder: (context) => const LoginScreen()));
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
