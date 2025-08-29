import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrchrms/app/IncludeFiles/_appbar.dart';
import 'package:mrchrms/app/modules/permistion_report_module/permistion_report_controller.dart';


class PermistionReportPage extends GetView<PermistionReportController> {
  @override
  Widget build(BuildContext context)=>GetBuilder<PermistionReportController>(builder: (myController) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: height/10,
                width: width,
                alignment: Alignment.center,
                child: MyAppBar(screenName: 'Permision Reports',),
              ),
              Row(
                children: [
                  Container(
                    height: height/12,
                    width: width/2.1,
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(height/10)),
                      color: Colors.white,
                      shadowColor: Colors.black,
                      child: TextField(
                        controller: myController.fromdateShow,
                        readOnly:true ,
                        onTap: (){
                          myController.selectToDate(context,1);
                        },
                        cursorColor: Colors.black12,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'From Date',
                            prefixIcon: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.all(Radius.circular(height/15)),
                              child: const Icon(
                                Icons.date_range,
                                color: Colors.orange,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: height/50)),
                      ),
                    ),
                  ),
                  Container(
                    height: height/12,
                    width: width/2.1,
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(height/10)),
                      color: Colors.white,
                      shadowColor: Colors.black,
                      child: TextField(
                        controller: myController.todateShow,
                        readOnly:true ,
                        onTap: (){
                          myController.selectToDate(context,2);
                          //controler.selectToDate(1,context);
                        },
                        cursorColor: Colors.black12,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Date',
                            prefixIcon: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.all(Radius.circular(height/15)),
                              child: const Icon(
                                Icons.date_range,
                                color: Colors.orange,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: height/50)),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: height/100,),
              Container(
                height: height/1.2,
                width: width/1.1,
                child: ListView.builder(
                  itemCount: controller.secScreenData.length,
                  itemBuilder: (BuildContext context1, int index) {
                    return Card(
                      //color: Colors.red,
                      child: ListTile(
                        title: Column(
                          children: [
                            SizedBox(
                              width: width,
                              child: Text(
                                  controller.secScreenData[index].fROMDATE.toString(),
                                  style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500)
                              ),
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: width,
                              child: Row(
                                children: [
                                  Container(
                                    width: width/4.5,
                                    child: Text(
                                        "From Time",
                                        style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500)
                                    ),
                                  ),
                                  Container(
                                    width: width/3.5,
                                    child: Text(
                                        controller.secScreenData[index].fROMTIME.toString(),
                                        style: const TextStyle(color: Colors.teal,fontWeight: FontWeight.w500)
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: width,
                              child: Row(
                                children: [
                                  Container(
                                    width: width/4.5,
                                    child: Text(
                                        "To Time",
                                        style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500)
                                    ),
                                  ),
                                  Container(
                                    width: width/3.5,
                                    child: Text(
                                        controller.secScreenData[index].tOTIME.toString(),
                                        style: const TextStyle(color: Colors.teal,fontWeight: FontWeight.w500)
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: width,
                              child: Row(
                                children: [
                                  Container(
                                    width: width/4.5,
                                    child: Text(
                                        "Total Time",
                                        style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500)
                                    ),
                                  ),
                                  Container(
                                    width: width/3.5,
                                    child: Text(
                                        controller.secScreenData[index].tOTALTIME.toString(),
                                        style: const TextStyle(color: Colors.teal,fontWeight: FontWeight.w500)
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: width,
                              child: Row(
                                children: [
                                  Container(
                                    width: width/4.5,
                                    child: Text(
                                        "Purpose",
                                        style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500)
                                    ),
                                  ),
                                  Container(
                                    width: width/3.5,
                                    child: Text(
                                        controller.secScreenData[index].pURPOSEOFVIST.toString(),
                                        style: const TextStyle(color: Colors.teal,fontWeight: FontWeight.w500)
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: width,
                              child: Row(
                                children: [
                                  Container(
                                    width: width/4.5,
                                    child: Text(
                                        "Status",
                                        style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500)
                                    ),
                                  ),
                                  Container(
                                    width: width/3.5,
                                    child: Text(
                                        controller.secScreenData[index].sTATUS.toString()=="P"?"Pending":
                                        controller.secScreenData[index].sTATUS.toString()=="A"?"Approve":"Cancel",
                                        style: const TextStyle(color: Colors.pink,fontWeight: FontWeight.w500)
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                          ],
                        ),
                        dense: true,
                        leading: CircleAvatar(
                          maxRadius: 30,
                          minRadius: 30,
                          backgroundColor:Colors.blueAccent,
                          child: Text(controller.secScreenData[index].dOCNO.toString(),
                            style: TextStyle(color: Colors.white,fontSize: height/80),),
                        ),
                        onTap: (){


                        },
                      ),
                    );
                  },
                ),
              )


            ],
          ),
        ),
        persistentFooterButtons: [
          FloatingActionButton.extended(
            backgroundColor: Colors.green.shade700,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
            onPressed: () {

              myController.getScreenData();

            },
          )
        ],

      ),
    );
  });
}
