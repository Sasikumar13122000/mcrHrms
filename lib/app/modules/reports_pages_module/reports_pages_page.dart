import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrchrms/app/IncludeFiles/_appbar.dart';
import 'package:mrchrms/app/modules/reports_pages_module/reports_pages_controller.dart';


class ReportsPagesPage extends GetView<ReportsPagesController> {
  @override
  Widget build(BuildContext context)=>GetBuilder<ReportsPagesController>(builder: (controler) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  Container(
                    height: height/10,
                    width: width,
                    alignment: Alignment.center,
                    child: MyAppBar(screenName: 'Reports',),
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      width: width/1.1,
                      height: height/2,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Card(
                              elevation: 5,
                              child: SizedBox(
                                height: height/17.5,
                                width: width/1.2,
                                child: Row(
                                  children: [
                                    Container(
                                      height: height/16.6,
                                      width: width/8,
                                      color: Colors.black12,
                                      child: Icon(Icons.location_on_rounded,size: height/35,color: Colors.pinkAccent,),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        controler.getdashboardNavigation(7);
                                      },
                                      child: Container(
                                        height: height/16.9,
                                        width: width/1.8,
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: width/50),
                                        child: Text("Attendance",style: TextStyle(fontSize: height/50),),
                                        //color: Colors.red,
                                      ),
                                    ),
                                    Container(
                                      height: height/16.6,
                                      width: width/7.7,
                                      color: Colors.black26,
                                      child: Icon(Icons.folder,size: height/35,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height/90,),
                            Card(
                              elevation: 5,
                              child: SizedBox(
                                height: height/17.5,
                                width: width/1.2,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: height/16.6,
                                      width: width/8,
                                      color: Colors.black12,
                                      child: Icon(Icons.leave_bags_at_home,size: height/35,color: Colors.pinkAccent,),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        controler.getdashboardNavigation(8);
                                      },
                                      child: Container(
                                        height: height/16.9,
                                        width: width/1.8,
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: width/50),
                                        child: Text("Permission",style: TextStyle(fontSize: height/50),),
                                        //color: Colors.red,
                                      ),
                                    ),
                                    Container(
                                      height: height/16.6,
                                      width: width/7.7,
                                      color: Colors.black26,
                                      child: Icon(Icons.folder,size: height/35,),
                                    ),
                                    //SizedBox(width: width/100,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height/90,),
                            Card(
                              elevation: 5,
                              child: InkWell(
                                onTap: (){
                                  print("object");
                                  controler.getdashboardNavigation(9);
                                },
                                child: SizedBox(
                                  height: height/17.5,
                                  width: width/1.2,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/16.6,
                                        width: width/8,
                                        color: Colors.black12,
                                        child: Icon(Icons.leave_bags_at_home,size: height/35,color: Colors.pinkAccent,),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          controler.getdashboardNavigation(9);
                                        },
                                        child: Container(
                                          height: height/16.9,
                                          width: width/1.8,
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(left: width/50),
                                          child: Text("On Duty",style: TextStyle(fontSize: height/50),),
                                          //color: Colors.red,
                                        ),
                                      ),
                                      Container(
                                        height: height/16.6,
                                        width: width/7.7,
                                        color: Colors.black26,
                                        child: Icon(Icons.folder,size: height/35,),
                                      ),
                                      //SizedBox(width: width/15,),

                                    ],
                                  ),
                                ),
                              ),
                            ),


                          ],

                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

      ),
    );
  });
}
