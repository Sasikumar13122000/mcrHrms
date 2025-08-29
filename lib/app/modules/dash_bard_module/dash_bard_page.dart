import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/dash_bard_module/dash_bard_controller.dart';


class DashBardPage extends GetView<DashBardController> {
  const DashBardPage({super.key});

  @override
  Widget build(BuildContext context)=>GetBuilder<DashBardController>(builder: (controler) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: height/5,
                width: width,
                padding: EdgeInsets.all(height/90),
                child: Container(
                  height: height/5,
                  width: width/1.2,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(height/50),topRight: Radius.circular(height/50)),
                      gradient: LinearGradient(
                        colors:  [

                          // Colors.amber.shade900,
                          // Colors.amber.shade700,
                          // Colors.amber.shade500,
                          // Colors.amber.shade200,

                          Colors.blue.shade900,
                          Colors.blue.shade900,
                          Colors.blue.shade900,
                          Colors.blue.shade900,
                        ],
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: width/8,
                            height: height/20,
                            child: IconButton(onPressed: () {  }, icon: Icon(Icons.menu,color: Colors.white,),),
                          ),
                          Container(
                            width: width/2,
                            height: height/20,
                            alignment: Alignment.center,
                            child: Text("DASHBOARD".toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/60,color: Colors.white),),
                          ),
                          Container(
                            width: width/8,
                            height: height/20,
                            child: IconButton(onPressed: () {  }, icon: Icon(Icons.notification_add,color: Colors.white.withOpacity(0.8),),),
                          ),
                          Container(
                            width: width/8,
                            height: height/20,
                            child: IconButton(onPressed: () {  }, icon: Icon(Icons.supervised_user_circle_sharp,color: Colors.white.withOpacity(0.8)),),
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: width/1.5,
                            height: height/20,
                            alignment: Alignment.center,
                            child: Text("Welcome     ".toString() +controler.sessionName.toString()+" - "+controler.sessionEmpId.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/60,color: Colors.white),),
                          ),


                        ],
                      ),

                    ],
                  ),
                ),

              ),



              Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: height/10),
                child: Card(
                  color: Colors.blue[50],

                  elevation: 10,
                  child: Container(
                    width: width/1.1,

                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(height: height/25,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: (){
                                  controler.getdashboardNavigation(1);
                                },
                                child: Container(
                                  width: width/2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: height/11,
                                      child: Image.asset("assets/attendance.jpeg"),
                                      padding: const EdgeInsets.all(12),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                                      ),
                                      child: Text("Attendance",style: TextStyle(fontSize: height/70),),
                                      padding: const EdgeInsets.all(12),
                                    )
                                  ],
                                ),
                              ),
                              ),
                              // InkWell(
                              //   onTap: (){
                              //     controler.getdashboardNavigation(5);
                              //   },
                              //   child: Container(
                              //     width: width/4,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(12),
                              //       color: Colors.white,
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey.withOpacity(0.5),
                              //           spreadRadius: 5,
                              //           blurRadius: 7,
                              //           offset: Offset(0, 3),
                              //         ),
                              //       ],
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Container(
                              //           height: height/11,
                              //           child: Image.asset("assets/permision.jpeg"),
                              //           padding: const EdgeInsets.all(12),
                              //         ),
                              //         Container(
                              //           decoration: const BoxDecoration(
                              //               color: Colors.white,
                              //               borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                              //           ),
                              //           child: Text("Permission",style: TextStyle(fontSize: height/70),),
                              //           padding: const EdgeInsets.all(12),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // InkWell(
                              //   onTap: (){
                              //     controler.getdashboardNavigation(6);
                              //   },
                              //   child: Container(
                              //     width: width/4,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(12),
                              //       color: Colors.white,
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey.withOpacity(0.5),
                              //           spreadRadius: 5,
                              //           blurRadius: 7,
                              //           offset: Offset(0, 3),
                              //         ),
                              //       ],
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Container(
                              //           //onDuty.jpeg
                              //           height: height/11,
                              //           child: Image.asset("assets/onDuty.png"),
                              //           padding: const EdgeInsets.all(12),
                              //         ),
                              //         Container(
                              //           decoration: const BoxDecoration(
                              //               color: Colors.white,
                              //               borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                              //           ),
                              //           child: Text("On Duty",style: TextStyle(fontSize: height/70),),
                              //           padding: const EdgeInsets.all(12),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),

                          SizedBox(height: height/25,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: (){
                                  controler.getdashboardNavigation(7);
                                },
                                child: Container(
                                  width: width/2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: height/11,
                                        child: Image.asset("assets/leaveReq.png"),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                                        ),
                                        child: Text("Leave",style: TextStyle(fontSize: height/70),),
                                        padding: const EdgeInsets.all(12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // InkWell(
                              //   onTap: (){
                              //     //controler.getdashboardNavigation(8);
                              //   },
                              //   child: Container(
                              //     width: width/4,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(12),
                              //       color: Colors.white,
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey.withOpacity(0.5),
                              //           spreadRadius: 5,
                              //           blurRadius: 7,
                              //           offset: Offset(0, 3),
                              //         ),
                              //       ],
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Container(
                              //           height: height/11,
                              //           child: Image.asset("assets/overtime.png"),
                              //           padding: const EdgeInsets.all(12),
                              //         ),
                              //         Container(
                              //           decoration: const BoxDecoration(
                              //               color: Colors.white,
                              //               borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                              //           ),
                              //           child: Text("Overtime",style: TextStyle(fontSize: height/70),),
                              //           padding: const EdgeInsets.all(12),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // InkWell(
                              //   onTap: (){
                              //     controler.getdashboardNavigation(10);
                              //   },
                              //   child: Container(
                              //     width: width/4,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(12),
                              //       color: Colors.white,
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey.withOpacity(0.5),
                              //           spreadRadius: 5,
                              //           blurRadius: 7,
                              //           offset: Offset(0, 3),
                              //         ),
                              //       ],
                              //     ),
                              //     child: Column(
                              //       children: [
                              //         Container(
                              //           height: height/11,
                              //           child: Image.asset("assets/reports.png"),
                              //           padding: const EdgeInsets.all(12),
                              //         ),
                              //         Container(
                              //           decoration: const BoxDecoration(
                              //               color: Colors.white,
                              //               borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                              //           ),
                              //           child: Text("Reports",style: TextStyle(fontSize: height/70),),
                              //           padding: const EdgeInsets.all(12),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),


                          // Card(
                          //   elevation: 5,
                          //   child: SizedBox(
                          //     height: height/17.5,
                          //     width: width/1.2,
                          //     child: Row(
                          //       children: [
                          //         Container(
                          //           height: height/16.6,
                          //           width: width/8,
                          //           color: Colors.black12,
                          //           child: Icon(Icons.location_on_rounded,size: height/35,color: Colors.pinkAccent,),
                          //         ),
                          //         InkWell(
                          //           onTap: (){
                          //
                          //           },
                          //           child: Container(
                          //             height: height/16.9,
                          //             width: width/1.8,
                          //             alignment: Alignment.centerLeft,
                          //             margin: EdgeInsets.only(left: width/50),
                          //             child: Text("Attendance",style: TextStyle(fontSize: height/50),),
                          //             //color: Colors.red,
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: (){
                          //             controler.getdashboardNavigation(7);
                          //           },
                          //           child: Container(
                          //             height: height/16.6,
                          //             width: width/7.7,
                          //             color: Colors.black26,
                          //             child: Icon(Icons.folder,size: height/35,),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // // SizedBox(height: height/90,),
                          // // Card(
                          // //   elevation: 5,
                          // //   child: SizedBox(
                          // //     height: height/17.5,
                          // //     width: width/1.2,
                          // //     child: Row(
                          // //       children: [
                          // //         Container(
                          // //           height: height/16.6,
                          // //           width: width/8,
                          // //           color: Colors.black12,
                          // //           child: Icon(Icons.call,size: height/35,color: Colors.pinkAccent,),
                          // //         ),
                          // //         InkWell(
                          // //           onTap: (){
                          // //             controler.getdashboardNavigation(2);
                          // //           },
                          // //           child: Container(
                          // //             height: height/16.9,
                          // //             width: width/1.8,
                          // //             alignment: Alignment.centerLeft,
                          // //             margin: EdgeInsets.only(left: width/50),
                          // //             child: Text("Telecalling Enquery",style: TextStyle(fontSize: height/50),),
                          // //             //color: Colors.red,
                          // //           ),
                          // //         ),
                          // //         InkWell(
                          // //           onTap: (){
                          // //             controler.getdashboardNavigation(24);
                          // //           },
                          // //           child: Container(
                          // //             height: height/16.6,
                          // //             width: width/7.7,
                          // //             color: Colors.black26,
                          // //             child: Icon(Icons.folder,size: height/35,),
                          // //           ),
                          // //         ),
                          // //       ],
                          // //     ),
                          // //   ),
                          // // ),
                          //
                          // // SizedBox(height: height/90,),
                          // // Card(
                          // //   elevation: 5,
                          // //   child: SizedBox(
                          // //     height: height/17.5,
                          // //     width: width/1.2,
                          // //     child: Row(
                          // //       children: [
                          // //         Container(
                          // //           height: height/16.6,
                          // //           width: width/8,
                          // //           color: Colors.black12,
                          // //           child: Icon(Icons.location_on_rounded,size: height/35,color: Colors.pinkAccent,),
                          // //         ),
                          // //         InkWell(
                          // //           onTap: (){
                          // //             controler.getdashboardNavigation(3);
                          // //           },
                          // //           child: Container(
                          // //             height: height/16.9,
                          // //             width: width/1.8,
                          // //             alignment: Alignment.centerLeft,
                          // //             margin: EdgeInsets.only(left: width/50),
                          // //             child: Text("Client visit",style: TextStyle(fontSize: height/50,),),
                          // //             //color: Colors.red,
                          // //           ),
                          // //         ),
                          // //         InkWell(
                          // //           onTap: (){
                          // //             controler.getdashboardNavigation(16);
                          // //           },
                          // //           child: Container(
                          // //             height: height/16.6,
                          // //             width: width/7.7,
                          // //             color: Colors.black26,
                          // //             child: Icon(Icons.folder,size: height/35,),
                          // //           ),
                          // //         ),
                          // //       ],
                          // //     ),
                          // //   ),
                          // // ),
                          // // SizedBox(height: height/90,),
                          // // Card(
                          // //   elevation: 5,
                          // //   child: SizedBox(
                          // //     height: height/17.5,
                          // //     width: width/1.2,
                          // //     child: Row(
                          // //       children: [
                          // //         Container(
                          // //           height: height/16.6,
                          // //           width: width/8,
                          // //           color: Colors.black12,
                          // //           child: Icon(Icons.leave_bags_at_home,size: height/35,color: Colors.pinkAccent,),
                          // //         ),
                          // //         InkWell(
                          // //           onTap: (){
                          // //             controler.getdashboardNavigation(4);
                          // //           },
                          // //           child: Container(
                          // //             height: height/16.9,
                          // //             width: controler.sessionType=="Y"?width/2.8:width/1.8,
                          // //             alignment: Alignment.centerLeft,
                          // //             margin: EdgeInsets.only(left: width/50),
                          // //             child: Text("Leave Master",style: TextStyle(fontSize: height/50),),
                          // //             //color: Colors.red,
                          // //           ),
                          // //         ),
                          // //         InkWell(
                          // //           onTap: (){
                          // //             controler.getdashboardNavigation(17);
                          // //           },
                          // //           child: Container(
                          // //             height: height/16.6,
                          // //             width: width/7.7,
                          // //             color: Colors.black26,
                          // //             child: Icon(Icons.folder,size: height/35,),
                          // //           ),
                          // //         ),
                          // //         //SizedBox(width: width/15,),
                          // //         Visibility(
                          // //           visible: controler.sessionType=="Y"?true:false,
                          // //           child: InkWell(
                          // //             onTap: (){
                          // //               controler.getdashboardNavigation(20);
                          // //             },
                          // //             child: Container(
                          // //               height: height/16.6,
                          // //               width: width/7.7,
                          // //               color: Colors.redAccent,
                          // //               child: Icon(Icons.approval,size: height/35,color: Colors.white,),
                          // //             ),
                          // //           ),
                          // //         ),
                          // //       ],
                          // //     ),
                          // //   ),
                          // // ),
                          // SizedBox(height: height/90,),
                          // Card(
                          //   elevation: 5,
                          //   child: SizedBox(
                          //     height: height/17.5,
                          //     width: width/1.2,
                          //     child: Row(
                          //       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Container(
                          //           height: height/16.6,
                          //           width: width/8,
                          //           color: Colors.black12,
                          //           child: Icon(Icons.leave_bags_at_home,size: height/35,color: Colors.pinkAccent,),
                          //         ),
                          //         InkWell(
                          //           onTap: (){
                          //             controler.getdashboardNavigation(5);
                          //           },
                          //           child: Container(
                          //             height: height/16.9,
                          //             width: controler.sessionType=="Y"?width/2.8:width/1.8,
                          //             alignment: Alignment.centerLeft,
                          //             margin: EdgeInsets.only(left: width/50),
                          //             child: Text("Permision",style: TextStyle(fontSize: height/50),),
                          //             //color: Colors.red,
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: (){
                          //             controler.getdashboardNavigation(8);
                          //           },
                          //           child: Container(
                          //             height: height/16.6,
                          //             width: width/7.7,
                          //             color: Colors.black26,
                          //             child: Icon(Icons.folder,size: height/35,),
                          //           ),
                          //         ),
                          //         //SizedBox(width: width/100,),
                          //         Visibility(
                          //           visible: controler.sessionType=="Y"?true:false,
                          //           child: InkWell(
                          //             onTap: (){
                          //               controler.getdashboardNavigation(21);
                          //             },
                          //             child: Container(
                          //               height: height/16.6,
                          //               width: width/7.7,
                          //               color: Colors.redAccent,
                          //               child: Icon(Icons.approval,size: height/35,color: Colors.white,),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: height/90,),
                          // Card(
                          //   elevation: 5,
                          //   child: InkWell(
                          //     onTap: (){
                          //       print("object");
                          //       controler.getdashboardNavigation(6);
                          //     },
                          //     child: SizedBox(
                          //       height: height/17.5,
                          //       width: width/1.2,
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/8,
                          //             color: Colors.black12,
                          //             child: Icon(Icons.leave_bags_at_home,size: height/35,color: Colors.pinkAccent,),
                          //           ),
                          //           InkWell(
                          //             onTap: (){
                          //               controler.getdashboardNavigation(6);
                          //             },
                          //             child: Container(
                          //               height: height/16.9,
                          //               width: controler.sessionType=="Y"?width/2.8:width/1.8,
                          //               alignment: Alignment.centerLeft,
                          //               margin: EdgeInsets.only(left: width/50),
                          //               child: Text("On Duty",style: TextStyle(fontSize: height/50),),
                          //               //color: Colors.red,
                          //             ),
                          //           ),
                          //           InkWell(
                          //             onTap: (){
                          //               controler.getdashboardNavigation(9);
                          //             },
                          //             child: Container(
                          //               height: height/16.6,
                          //               width: width/7.7,
                          //               color: Colors.black26,
                          //               child: Icon(Icons.folder,size: height/35,),
                          //             ),
                          //           ),
                          //           //SizedBox(width: width/15,),
                          //           Visibility(
                          //             visible: controler.sessionType=="Y"?true:false,
                          //             child: InkWell(
                          //               onTap: (){
                          //                 controler.getdashboardNavigation(9);
                          //               },
                          //               child: Container(
                          //                 height: height/16.6,
                          //                 width: width/7.7,
                          //                 color: Colors.redAccent,
                          //                 child: Icon(Icons.approval,size: height/35,color: Colors.white,),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: height/50,),
                          Container(
                            width: width/1.2,
                            alignment: Alignment.center,
                            child: Text("YOU REPORT TO",style: TextStyle(fontSize: height/60,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: height/50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: width/1.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Icon(Icons.account_circle, size: height/20, color:Colors.blue[900]),
                                      padding: const EdgeInsets.all(12),
                                    ),
                                    Container(
                                      child: Text(controler.sessionManager,style: TextStyle(fontSize: height/60,fontWeight: FontWeight.w700),),
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: height/25,),
                          // Card(
                          //   elevation: 5,
                          //   child: InkWell(
                          //     onTap: (){
                          //       controler.getdashboardNavigation(10);
                          //     },
                          //     child: SizedBox(
                          //       height: height/17.5,
                          //       width: width/1.2,
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/8,
                          //             color: Colors.black12,
                          //             child: Icon(Icons.currency_rupee_rounded,size: height/35,color: Colors.pinkAccent,),
                          //           ),
                          //           Container(
                          //             height: height/16.9,
                          //             width: width/1.8,
                          //             alignment: Alignment.centerLeft,
                          //             margin: EdgeInsets.only(left: width/50),
                          //             child: Text("Reimbursement",style: TextStyle(fontSize: height/50),),
                          //             //color: Colors.red,
                          //           ),
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/7.7,
                          //             color: Colors.black26,
                          //             child: Icon(Icons.folder,size: height/35,),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: height/90,),
                          // Card(
                          //   elevation: 5,
                          //   child: InkWell(
                          //     onTap: (){
                          //       controler.getdashboardNavigation(12);
                          //     },
                          //     child: SizedBox(
                          //       height: height/17.5,
                          //       width: width/1.2,
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/8,
                          //             color: Colors.black12,
                          //             child: Icon(Icons.holiday_village_rounded,size: height/35,color: Colors.pinkAccent,),
                          //           ),
                          //           Container(
                          //             height: height/16.9,
                          //             width: width/1.8,
                          //             alignment: Alignment.centerLeft,
                          //             margin: EdgeInsets.only(left: width/50),
                          //             child: Text("Holiday",style: TextStyle(fontSize: height/50),),
                          //             //color: Colors.red,
                          //           ),
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/7.7,
                          //             color: Colors.black26,
                          //             child: Icon(Icons.folder,size: height/35,),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: height/90,),
                          // Card(
                          //   elevation: 5,
                          //   child: InkWell(
                          //     onTap: (){
                          //       controler.getdashboardNavigation(14);
                          //     },
                          //     child: SizedBox(
                          //       height: height/17.5,
                          //       width: width/1.2,
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/8,
                          //             color: Colors.black12,
                          //             child: Icon(Icons.holiday_village_rounded,size: height/35,color: Colors.pinkAccent,),
                          //           ),
                          //           Container(
                          //             height: height/16.9,
                          //             width: width/1.8,
                          //             alignment: Alignment.centerLeft,
                          //             margin: EdgeInsets.only(left: width/50),
                          //             child: Text("Client Reports",style: TextStyle(fontSize: height/50),),
                          //             //color: Colors.red,
                          //           ),
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/7.7,
                          //             color: Colors.black26,
                          //             child: Icon(Icons.folder,size: height/35,),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: height/90,),
                          // Card(
                          //   elevation: 5,
                          //   child: InkWell(
                          //     onTap: (){
                          //       controler.getdashboardNavigation(26);
                          //     },
                          //     child: SizedBox(
                          //       height: height/17.5,
                          //       width: width/1.2,
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/8,
                          //             color: Colors.black12,
                          //             child: Icon(Icons.account_circle,size: height/35,color: Colors.pinkAccent,),
                          //           ),
                          //           Container(
                          //             height: height/16.9,
                          //             width: width/1.8,
                          //             alignment: Alignment.centerLeft,
                          //             margin: EdgeInsets.only(left: width/50),
                          //             child: Text("To Activity",style: TextStyle(fontSize: height/50),),
                          //             //color: Colors.red,
                          //           ),
                          //           Container(
                          //             height: height/16.6,
                          //             width: width/7.7,
                          //             color: Colors.black26,
                          //             child: Icon(Icons.folder,size: height/35,),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],

                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: height/10,
                width: width,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: height/7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(height/60)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue.shade400 , Colors.white],
                          //colors: [Colors.amber.shade200 , Colors.white],
                          stops: [0.2, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [

                          SizedBox(height: height/50,),

                          Container(
                            width: width/5,
                            alignment: Alignment.center,
                            child: Text(" Total Days ",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: height/60
                            ),
                            ),
                          ),
                          SizedBox(height: height/60,),
                          Container(
                            width: width/5,
                            alignment: Alignment.center,
                            child: Text(" 30",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900.withOpacity(0.5),
                                fontSize: height/50
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(height/60)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue.shade400 , Colors.white],
                          //colors: [Colors.amber.shade200 , Colors.white],
                          stops: [0.2, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [

                          SizedBox(height: height/50,),

                          Container(
                            width: width/5,
                            alignment: Alignment.center,
                            child: Text("Present",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: height/60
                            ),
                            ),
                          ),
                          SizedBox(height: height/60,),
                          Container(
                            width: width/5,
                            alignment: Alignment.center,
                            child: Text("18",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900.withOpacity(0.5),
                                fontSize: height/50
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(height/60)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue.shade400 , Colors.white],
                          //colors: [Colors.amber.shade200 , Colors.white],
                          stops: [0.2, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [

                          SizedBox(height: height/50,),

                          Container(
                            width: width/5,
                            alignment: Alignment.center,
                            child: Text("Leave",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: height/60
                            ),
                            ),
                          ),
                          SizedBox(height: height/60,),
                          Container(
                            width: width/5,
                            alignment: Alignment.center,
                            child: Text("2",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900.withOpacity(0.5),
                                fontSize: height/50
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(height/60)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue.shade400 , Colors.white],
                          //colors: [Colors.amber.shade200 , Colors.white],
                          stops: [0.2, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [

                          SizedBox(height: height/50,),

                          Container(
                            width: width/5,
                            alignment: Alignment.center,
                            child: Text("Week Of",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: height/60
                            ),
                            ),
                          ),
                          SizedBox(height: height/60,),
                          Container(
                            width: width/5,
                            alignment: Alignment.center,
                            child: Text("4",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900.withOpacity(0.5),
                                fontSize: height/50
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[900],
          //backgroundColor: Colors.amber,
          onPressed: () {
            controller.exitPage();
          },
          child: Icon(Icons.exit_to_app,color: Colors.white,),
        )
      ),
    );
  });
}
