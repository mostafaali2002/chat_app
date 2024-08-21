import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/login_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chat_App());
}

class Chat_App extends StatelessWidget {
  const Chat_App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => const RegisterView(),
        ChatView.id: (context) => const ChatView(),
        SplashView.id: (context) => const SplashView()
      },
      initialRoute: SplashView.id,
    );
  }
}
