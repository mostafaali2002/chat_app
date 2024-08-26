import 'dart:async';
import 'package:chat_app/views/login_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static String id = "splash";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, LoginView.id);
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: double.maxFinite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(200),
            topLeft: Radius.circular(200),
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Image.asset("assets/logo.png"),
            const SizedBox(height: 20),
            const Text(
              "Chat App",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
