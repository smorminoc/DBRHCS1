import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhcs/responsive/mobile_screen_layout.dart';
import 'package:rhcs/responsive/responsive_layout_screen.dart';
import 'package:rhcs/responsive/web_screen_layout.dart';
import 'package:rhcs/screen/login_screen.dart';
import 'package:rhcs/services/auth/auh_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RRHH',
      theme: ThemeData.dark(),
      home: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          
            case ConnectionState.done:
                 final user = AuthService.firebase().currentUser;
                if (user != null) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                } else {
                  return const LoginScreen();
                }
            default:
             return const Center(child: CircularProgressIndicator());  
          }
        }
          
      ),
    );
  }
}