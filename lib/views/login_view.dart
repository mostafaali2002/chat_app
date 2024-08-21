import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/snack_bar_message.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = "LoginView";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    bool isLoad = false;
    return ModalProgressHUD(
      inAsyncCall: isLoad,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40)),
          ),
          centerTitle: true,
          title: Column(
            children: [
              Image.asset(
                Klogo,
                height: 90,
                width: 130,
                fit: BoxFit.fill,
              ),
              const Text(
                "Welcom Back",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  preicon: const Icon(Icons.email),
                  hint: "example@gmail.com",
                  label: "Email",
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "Field is required";
                    }
                  },
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  obscureText: true,
                  preicon: const Icon(Icons.lock),
                  sufficon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {},
                  ),
                  hint: "**********",
                  label: "Password",
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "Field is required";
                    }
                  },
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  width: double.infinity,
                  btnColor: Colors.blue,
                  text: "Login",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      isLoad = true;
                      setState(() {});
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        Navigator.pushNamed(context, ChatView.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          SnackBarMessage(
                              context, "user-not-found", Colors.red);
                        } else if (e.code == 'wrong-password') {
                          SnackBarMessage(
                              context, "wrong-password", Colors.red);
                        } else if (e.code == "too-many-requests") {
                          SnackBarMessage(
                              context, "too-many-requests", Colors.red);
                        } else if (e.code ==
                            "The email address is badly formatted") {
                          SnackBarMessage(
                              context,
                              "The email address is badly formatted",
                              Colors.red);
                        } else if (e.code == "invalid-email") {
                          SnackBarMessage(context, "invalid-email", Colors.red);
                        } else if (e.code == "invalid-credential") {
                          SnackBarMessage(
                              context, "invalid-credential", Colors.red);
                        }
                      } catch (e) {
                        SnackBarMessage(
                            context, "There was an error", Colors.red);
                      }
                      isLoad = false;
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an accound ?",
                      style: TextStyle(fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterView.id);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 17),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 50,
                  color: Color.fromARGB(60, 0, 0, 0),
                  thickness: 3,
                  endIndent: 30,
                  indent: 30,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(CircleBorder()),
                      backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: () async {
                    Auth().logInWithGoogle();
                  },
                  child: const Image(
                    image: AssetImage("assets/icons8-google-48.png"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
