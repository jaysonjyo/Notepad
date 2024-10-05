
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Signin.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
//signup

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool isvisible1 = true;
  bool isvisible2 = true;
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
                    height: 40.h,
                  ),
                  Text(
                    'Create an \naccount',
                    style: TextStyle(
                            color: Colors.black,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.h
                        )),

                  SizedBox(
                    height: 30.h,
                  ),
                  TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(

                        ),enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)

                    ),
                        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        hintText: 'Email',
                        hintStyle:  TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        )),
                    // validator: (value) {
                    //   if (value!.isEmpty ||
                    //       !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //           .hasMatch(value)) {
                    //     return 'Enter a valid email!';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextField(controller: password,
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: isvisible1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)

                        ),
                        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                        hintText: 'Password',
                        hintStyle:  TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: InkWell(
                          child: Icon(Icons.visibility),
                          onTap: () {
                            setState(() {
                              isvisible1 = !isvisible1;
                            });
                          },
                        )),

                    // validator: (value){
                    //   if (value!.isEmpty || value.length<6) {
                    //     return 'Enter a valid password!....';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextField(
                    controller: confirmpassword,
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: true,
                    decoration: InputDecoration(
                      border:OutlineInputBorder(

                      ),enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)

                    ),
                      focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      hintText: 'ConfirmPassword',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,


                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // validator:  (value) {
                    //   if (value!.isEmpty || value.length<6) {
                    //     return 'Enter a valid password!....';
                    //   }
                    //   else if(password.text!= confirmpassword.text){
                    //     return "Enter correct password";
                    //
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 258.w,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By clicking the ',
                            style:  TextStyle(
                                  color: Color(0xFF676767),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                                  color: Color(0xFFFF4B26),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                )),

                          TextSpan(
                              text: ' button, you agree to the public offer',
                              style:  TextStyle(
                                    color: Color(0xFF676767),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(onTap: () async {
                    // final isValid = _formKey.currentState!.validate();
                    // if (isValid) {
                      await  auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((onValue){
                        firestore.doc(auth.currentUser!.uid.toString()).set({
                          "id": auth.currentUser!.uid.toString(),
                          "email": email.text,
                          "password": password.text,
                          "ConfirmPassword":confirmpassword.text,


                        });

                        // Fluttertoast.showToast(msg: 'Successfully registerd');
                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Login()),(route)=>false);

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
                          'Create Account',
                          style:  TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              )),

                      ),
                    ),
                  ),


                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'I Already Have an Account',
                          //  textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF575757),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                      SizedBox(width: 5.w),
                      GestureDetector(onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Login()),(route)=>false);
                      },
                        child: Text(
                            'Login',
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFF73658),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFFF73658))),

                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
