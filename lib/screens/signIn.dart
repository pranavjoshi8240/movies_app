import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/screens/signUp.dart';
import '../Firebase/FirebaseAuth.dart';
import '../main.dart';
import '../utils/style.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _PassCntlr = TextEditingController();
  final TextEditingController _emailCntlr = TextEditingController();
  bool isObscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).viewPadding.top + 180,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff6DB6AA).withOpacity(0.7),
                      Color(0xffD0EDE8).withOpacity(0.6),
                      Color(0xffF0FFFD).withOpacity(0.6),
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:MediaQuery.of(context).viewPadding.top + 70,),
                      const SizedBox(height: 30,),
                      Center(
                        child: Text("Welcome",style: font36black,),
                      ),
                      const SizedBox(height: 60,),
                      Text("Email",style: textFieldLabel,),
                      const SizedBox(height: 10,),
                      TextFormField(
                        validator: (input) => input!.isValidEmail() ? null : "Check your email",
                        controller: _emailCntlr,
                        cursorColor: Color(0xff211407),
                        style: font20blackmini,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          //contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          hintText: "Enter Email",
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Text("Password".tr,style: textFieldLabel,),
                      const SizedBox(height: 10,),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) return 'Password is Reuqired'.tr;
                          return null;
                        },
                        controller: _PassCntlr,
                        obscureText: isObscure,
                        cursorColor: Color(0xff211407),
                        style: font20blackmini,
                        decoration: InputDecoration(
                            isDense: true,
                            suffixIcon: isObscure==false ?
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    isObscure =! isObscure;
                                  });
                                },
                                child: Icon(Icons.visibility_off_outlined))
                                : InkWell(
                                onTap: (){
                                  setState(() {
                                    isObscure =! isObscure;
                                  });
                                },
                                child: Icon(Icons.visibility_outlined)),
                            filled: true,
                            fillColor: Colors.white,
                            //contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                            hintText: "Enter Password"
                        ),
                      ),
                      const SizedBox(height: 50,),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xff83C0BF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                )
                            ),
                            onPressed: () async{
                              if (_formKey.currentState!.validate()) {
                                  final message = await AuthService().login(
                                    email: _emailCntlr.text,
                                    password: _PassCntlr.text,
                                  );
                                  if (message!.contains('Success')) {
                                    await sharedPreferences.setBool("isLoggedIn",true);
                                    Get.offAll(()=>HomeScreen());
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                    ),
                                  );
                              }
                            }, child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Poppins"),),
                        )),
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                )
                            ),
                            onPressed: () async {
                               await AuthService.signInWithGoogle(context: context);
                            },
                            child: Center(
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/Group 108.png"),
                                  const SizedBox(width: 8,),
                                  const Text("Sign in with google",
                                    style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Poppins"),),
                                ],
                              ),
                            )
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account?",
                            style: TextStyle(color: Color(0xff707B81),fontSize: 16,fontFamily: "Poppins"),),
                          const SizedBox(width: 8,),
                          InkWell(
                            onTap: (){
                              Get.to(()=>SignUpScreen());
                            },
                            child: const Text(
                              "Sign Up for Free",
                              style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "Poppins"),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}