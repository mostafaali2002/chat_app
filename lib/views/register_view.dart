import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/snack_bar_message.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = "RegisterView";
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                "Create Account",
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
                    return null;
                  },
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  preicon: const Icon(Icons.lock),
                  obscureText: true,
                  sufficon: IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () {},
                  ),
                  hint: "**********",
                  label: "Password",
                  validator: (data) {
                    if (data!.isEmpty) {
                      return "Field is required";
                    }
                    return null;
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
                  text: "Register",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      isLoad = true;
                      setState(() {});
                      try {
                        UserCredential credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        Navigator.pushNamed(context, ChatView.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          SnackBarMessage(context, "weak password", Colors.red);
                        } else if (e.code == 'email-already-in-use') {
                          SnackBarMessage(
                              context, "email already in use", Colors.red);
                        }
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
                      "Have an accound ?",
                      style: TextStyle(fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
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
                  onPressed: () {},
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
