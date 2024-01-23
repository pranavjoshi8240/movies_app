import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/screens/signIn.dart';
import '../Firebase/FirebaseAuth.dart';
import '../main.dart';
import '../utils/style.dart';
import 'home_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameCntlr = TextEditingController();
  TextEditingController lastNameCntlr = TextEditingController();
  TextEditingController emailCntlr = TextEditingController();
  TextEditingController passwordCntlr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  var EmailController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: Stack(
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
                    SizedBox(height:  MediaQuery.of(context).viewPadding.top +20,),
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xffFFFFFF),
                        radius: 22,
                        child: Center(child: Icon(Icons.arrow_back_ios_new_outlined,size: 16,)),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: Text("Create Account",style: font36black,),
                    ),
                    Center(
                      child: Text("Let’s Create Account Together",style: font20blackmini,textAlign: TextAlign.center,),
                    ),
                    SizedBox(height: 30,),
                    Text("Email",style: textFieldLabel,),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (input) => input!.isValidEmail() ? null : "Check your email",
                      controller: emailCntlr,
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
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          hintText: "Enter Email"
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text("Password",style: textFieldLabel,),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) return 'Password is Reuqired';
                        return null;
                      },
                      controller: passwordCntlr,
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
                    const SizedBox(height: 30,),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Color(0xff83C0BF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)
                              )
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()){
                              final message = await AuthService().registration(
                                email: emailCntlr.text,
                                password: passwordCntlr.text,
                              );
                              if (message!.contains('Success')) {
                                await sharedPreferences.setBool("isLoggedIn",true);
                                Get.offAll(()=>const HomeScreen());
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                            }
                          }, child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Poppins"),),
                      )),
                    ),
                    SizedBox(height: 30,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Color(0xff707B81),fontSize: 16,fontFamily: "Poppins"),),
                        SizedBox(width: 8,),
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "Poppins"),),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

