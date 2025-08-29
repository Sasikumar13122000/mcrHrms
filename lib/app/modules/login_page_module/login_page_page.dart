import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/login_page_module/login_page_controller.dart';


class LoginPagePage extends GetView<LoginPageController> {
  const LoginPagePage({super.key});

  @override
  Widget build(BuildContext context)=>GetBuilder<LoginPageController>(builder: (myController) {
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
                  height: height/3,
                  width: width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          // Colors.yellow.shade500,
                          // Colors.yellow.shade400,
                          // Colors.yellow.shade300,
                          // Colors.yellow.shade200,
                          // Colors.yellow.shade100,
                          // Colors.yellow.shade50,


                          Colors.blue.shade900,
                          Colors.blue.shade800,
                          Colors.blue.shade700,
                          Colors.blue.shade500,
                          Colors.blue.shade300,
                          Colors.blue.shade200,
                          Colors.blue.shade100,
                          Colors.blue.shade50,
                          Colors.white,
                        ],
                      begin: Alignment.topRight,
                    )
                  ),
                  child:Row(
                    children: [
                      SizedBox(width: width/5,),
                      Container(
                        width: width/3,
                        height: height/4,
                        child: CircleAvatar(
                          radius: 110,
                          backgroundColor: Colors.transparent,
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(height/4))
                              ),
                              child: Image.asset("assets/sedresremovebgpreview.png"),
                              //child: Image.asset("assets/demoLogo.jpeg"),
                            ),
                          ),
                        ),
                        //child: Icon(Icons.ac_unit_rounded),
                      ),
                      Container(
                        width: width/3,
                        height: height/4,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height/12,
                              width: width/3,
                            ),
                            SizedBox(
                              height: height/30,
                              width: width/3,
                              child: Text("Smart",style: TextStyle(fontSize: height/40,fontWeight: FontWeight.bold),),
                            ),

                            SizedBox(
                              height: height/20,
                              width: width/3,
                              child: Text("HR",style: TextStyle(fontSize: height/20,fontWeight: FontWeight.bold),),
                            ),


                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: height/20,
                  width: width,
                ),
            Container(
              child: Center(
                child: Card(
                  color: Colors.blue[50],
                  elevation: 10,
                  shadowColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: width / 1.3,
                      height: height/1.1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          SizedBox(
                            height: height / 15,
                            child: TextField(

                              controller: myController.userName,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "UserName",//10043
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: Icon(Icons.verified_user_rounded, color: Colors.blue[900]),
                              ),
                            ),
                          ),
                          SizedBox(height: height / 40),


                          SizedBox(
                            height: height / 15,
                            child: TextField(
                              controller: myController.userPasword,
                              cursorColor: Colors.grey,
                              obscureText: myController.passwordVisible,
                              decoration: InputDecoration(
                                hintText: "Password",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: Icon(Icons.password, color: Colors.blue[900]),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    myController.passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.blue[900],
                                  ),
                                  onPressed: () {
                                    myController.myPasswordVisible();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height / 30),

                          SizedBox(
                            height: height / 20,
                            width: width / 2,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                myController.locationpermisioncheck().then((value) {
                                  if (value) {
                                    myController.login();
                                  } else {
                                    myController.locationAleart(context);
                                  }
                                });
                              },
                              icon: Icon(Icons.login, size: height / 30, color: Colors.white),
                              label: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: height / 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
                SizedBox(
                  height: height/4,
                  width: width,
                ),
              ],
            ),
          ),
        ),
    );
  });
}
