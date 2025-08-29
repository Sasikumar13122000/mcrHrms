import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/splash_screen_module/splash_screen_controller.dart';


class SplashScreenPage extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context)=>GetBuilder<SplashScreenController>(builder: (builder) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height/2,
            width: width,
            color: Colors.white,
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/sedresremovebgpreview.png"),
            //child: Image.asset("assets/demoLogo.jpeg"),
          ),
          Container(
            height: height/2.1,
            width: width,
            color: Colors.white,
            alignment: Alignment.topCenter,
            child: Image.asset("assets/Loaging.gif"),
          ),
        ],
      ),
    );
  });
}
