import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataScreen extends StatefulWidget {
  final String title;
  final String content;
  const DataScreen({super.key, required this.title, required this.content});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  backgroundColor: Colors.white,),
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'sfprodisplay',
                fontWeight: FontWeight.w300,
                letterSpacing: 1.50.w,
              ),
            ),
            Text(
              widget.content,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'sfprodisplay',
                fontWeight: FontWeight.w300,
                letterSpacing: 1.50.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
