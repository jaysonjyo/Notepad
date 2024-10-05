
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/first.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
//login
class _LoginState extends State<Login> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isvisible=true;
   FirebaseAuth auth =FirebaseAuth.instance;
   final firestore = FirebaseFirestore.instance.collection("users");
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 65.h,
                  ),
                  Text(
                    'Welcome \nBack!\n',
                    style:  TextStyle(
                        color: Colors.black,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.h)

                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)

                        ),
                        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        )),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: password,
                    obscureText: isvisible,
                    decoration: InputDecoration(
                        border:OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)

                        ),
                        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        hintText: 'Password',
                        hintStyle:  TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),suffixIcon: InkWell(child: Icon(Icons.visibility),
                      onTap: (){
                        setState(() {
                          isvisible=! isvisible;
                        });
                      },

                    )
                    ),
                    validator:  (value) {
                      if (value!.isEmpty || value.length<6) {
                        return 'Enter a valid password!....';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style:  TextStyle(
                              color: Color(0xFFF73658),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,

                            )
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  GestureDetector(onTap: () async {
                    // final isValid = _formKey.currentState!.validate();
                    // if (isValid) {
                    auth
                        .signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text)
                        .then((onValue) {

                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Notepade()),(route)=>false);
                    });
                    // }
                    // _formKey.currentState?.save();
                  },
                    child: Container(
                      width: 317.w,
                      height: 55.h,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF73658),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r)),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style:  TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              )
                        ),
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Create An Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF575757),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,

                          )),
                      SizedBox(width: 5.w),
                      GestureDetector(onTap: (){Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Signup()),(route)=>false);},
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                                  color: Color(0xFFF73658),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,decorationColor:Color(0xFFF73658)
                              )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
