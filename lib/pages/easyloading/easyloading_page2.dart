import 'dart:developer';

import 'package:flutter/material.dart';

class EasyLoadingPage2 extends StatefulWidget {
  const EasyLoadingPage2({Key? key}) : super(key: key);

  @override
  State<EasyLoadingPage2> createState() => _EasyLoadingPage2State();
}

class _EasyLoadingPage2State extends State<EasyLoadingPage2> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x888888),
      child: Container(
        color: const Color(0x888888),
        child: Column(
          children: [
            //  Text(
            //     "The stream has ended",
            //     style:myTextStyle(color: AppColors.white, fontSize: 18.sp) ,
            //   ),
            const SizedBox(height: 50),
            const SizedBox(height: 50),
            const SizedBox(height: 50),
            const SizedBox(height: 50),
            okButton(context),
          ],
        ),
      ),
    );
  }

  GestureDetector okButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 315,
        height: 52,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'ok',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF701AC6),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
