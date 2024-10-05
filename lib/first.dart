import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/editnotes.dart';

import 'DataScreen.dart';

class Notepade extends StatefulWidget {
  const Notepade({super.key});

  @override
  State<Notepade> createState() => _NotepadeState();
}

class _NotepadeState extends State<Notepade> {
  TextEditingController searchcontroler = TextEditingController();

  // final firestore = FirebaseFirestore.instance.collection("data").snapshots();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.uid.toString())
        .collection("data")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Note Pad",
          style: TextStyle(fontSize: 25.sp, color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: Column(
            children: [
              Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.19, 6),
                    end: Alignment(0.09, -1),
                    colors: [Color(0x1BFFFFFF), Color(0xFF000C1B)],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: TextField(
                  controller: searchcontroler,
                  style:
                      TextStyle(color: Colors.white, decorationThickness: 0.sp),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      border: InputBorder.none,
                      hintText: 'What are you looking for..',
                      hintStyle: TextStyle(
                        color: Color(0xFF627387),
                        fontSize: 15.sp,
                        fontFamily: 'sfprodisplay',
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.50.w,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                      )),
                  onChanged: (value) {
                    setState(() {});
                  },
                  onSubmitted: (value) {
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
        backgroundColor: Color(0xFF000B17),
      ),
      backgroundColor: Color(0xFF000B17),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Editnotes()));
            },
            child: Container(
              width: double.infinity.w,
              height: 50.h,
              decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r))),
              child: Row(
                children: [
                  SizedBox(
                    width: 50.w,
                  ),
                  Text(
                    "add your notes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sfprodisplay',
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.50.w,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Icon(
                    Icons.edit,
                    size: 15.sp,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final title =
                            snapshot.data!.docs[index]["Title"].toString();
                        if (searchcontroler.text.isEmpty) {
                          return SizedBox();
                        } else if (title.toLowerCase().contains(
                            searchcontroler.text.toLowerCase().toString())) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => DataScreen(
                                      title: snapshot.data!.docs[index]["Title"]
                                          .toString(),
                                      content: snapshot.data!.docs[index]["Content"]
                                          .toString())));
                            },
                            child: Container(
                              width: double.infinity.w,
                              height: 60.h,
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      side: BorderSide(
                                          width: 1.w, color: Colors.grey))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]["Title"]
                                          .toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'sfprodisplay',
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1.50.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 330.w,
                                      height: 40.h,
                                      child: Text(
                                        snapshot.data!.docs[index]["Content"]
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'sfprodisplay',
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 1.50.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 5.h,
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox();
                }
              })
        ],
      ),
    );
  }
}
