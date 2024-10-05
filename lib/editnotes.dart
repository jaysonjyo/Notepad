import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Editnotes extends StatefulWidget {
  const Editnotes({super.key});

  @override
  State<Editnotes> createState() => _EditnotesState();
}

class _EditnotesState extends State<Editnotes> {
  TextEditingController titlecontroler= TextEditingController();
  TextEditingController contentcontroler =TextEditingController();



  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid.toString())
        .collection("data");

    return Scaffold(
      appBar: AppBar( actions:[Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child:  GestureDetector(onTap: (){
          final id = DateTime.now().microsecondsSinceEpoch.toString();
          firestore.doc(id).set({
            "Title": titlecontroler.text,
            "Content": contentcontroler.text,
            "id": id,
          }).then((onValue) {
            titlecontroler.clear();
            contentcontroler.clear();
          });
        },
          child: Text( "Add note",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: 'sfprodisplay',
              fontWeight: FontWeight.w300,
              letterSpacing: 1.50.w,
            ),),
        ),
      ),] ,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            Row(
              children: [
                SizedBox(width: 20.w,),
                Text( "*",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: 'sfprodisplay',
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.50.w,
                  ),),
                SizedBox(width: 20.w,),
                Expanded(
                  child: TextField(
                    controller: titlecontroler,
                    style:
                    TextStyle(color: Colors.black, decorationThickness: 0.sp),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        border: InputBorder.none,
                        hintText: 'Enter your Content Title',
                        hintStyle: TextStyle(
                          color: Color(0xFF627387),
                          fontSize: 15.sp,
                          fontFamily: 'sfprodisplay',
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.50.w,
                        ),
                       ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSubmitted: (value) {
                      setState(() {});
                    },
                  ),
                ),

              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: 10.w),
              child: Expanded(
                child: TextField(
                  controller: contentcontroler,maxLines: 10,
                  style:
                  TextStyle(color: Colors.black, decorationThickness: 0.sp),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                    border: InputBorder.none,
                    hintText: 'Enter your notes',
                    hintStyle: TextStyle(
                      color: Color(0xFF627387),
                      fontSize: 15.sp,
                      fontFamily: 'sfprodisplay',
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.50.w,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  onSubmitted: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
