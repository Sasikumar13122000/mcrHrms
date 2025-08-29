
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppBar extends StatefulWidget {
   MyAppBar( {Key? key,required this.screenName}) : super(key: key);
   var screenName='';

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          height: height/15,
          width: width,
          margin: EdgeInsets.only(top: height/50),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            //color: Colors.yellow,

              borderRadius: BorderRadius.all(Radius.circular(height/45)),
          ),

          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: width/20,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                    },
                  icon: Icon(Icons.arrow_back,color: Colors.white,),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: height/35),
                child: Text(widget.screenName,style: TextStyle(color: Colors.white,fontSize: height/40,fontWeight: FontWeight.w700),),
              ),
              SizedBox(width: width/4,),
            ],
          ),
        ),
      ),
    );
  }
}

