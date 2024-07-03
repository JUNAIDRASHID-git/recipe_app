import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/buttons/mainbutton.dart';
import 'package:recipe_app/colors/main_bg_colors.dart';
import 'package:recipe_app/db/dbfunctions/userfunctions.dart';
import 'package:recipe_app/screens/user_screen/login_screen.dart';
import 'package:recipe_app/widgets/textfields/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainbgcolor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Create",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Text(
                    "Your Account",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 160,),

            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      " REGISTER",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldMain(
                      icon: const Icon(Icons.mail),
                      prefixText: "Email",
                      obscuretext: false,
                      controller: _emailController,
                      validator: (value) {
                        
                        if(value==null || value.isEmpty){
                            return "Enter Your Email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldMain(
                      icon: const Icon(Icons.person),
                      prefixText: "UserName",
                      obscuretext: false,
                      controller: _usernameController,
                      validator: (value) {
                        if(value==null || value.isEmpty){
                            return "Please Enter UserName";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldMain(
                      icon: const Icon(Icons.lock),
                      prefixText: "Password",
                      obscuretext: true,
                      controller: _passwordController,
                      validator: (value) {
                        if(value==null || value.isEmpty){
                            return "Please Fill The Password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        log("Already have an Account pressed");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        "   Already have an Account",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 180,),

            MainButton(
              buttonTitle: "Sign Up",
              buttonAction: () {
                
               if(_formKey.currentState!.validate()){
                 addUser(
                    email: _emailController.text,
                    username: _usernameController.text,
                    password: _passwordController.text,
                    id: DateTime.now().millisecondsSinceEpoch.toString());
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
               }
               log("sign up pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
