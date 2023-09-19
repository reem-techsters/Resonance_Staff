import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/user_model_ctrl.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Data currentUser = GetUserData().getCurrentUser();
  UserModelController UserModelCtrl = Get.find<UserModelController>();
  @override
  Widget build(BuildContext contxt) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        //  appBar: AppBar(
        //   title: const Text('Flutter WillPopScope demo'),
        // ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Strings.primaryColor, Colors.blue.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                              size: Strings.width(context) / 10,
                              color: Colors.white,
                              Icons.arrow_back_ios)),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 10, top: 20),
                  //     child: GestureDetector(
                  //         onTap: () {
                  //           Scaffold.of(context).openDrawer();
                  //         },
                  //         child: Icon(
                  //             size: Strings.width(context) / 10,
                  //             color: Colors.white,
                  //             Icons.menu)),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      // CircleAvatar(
                      //   backgroundColor: Strings.primaryColor,
                      //   minRadius: 35.0,
                      //   child: Icon(
                      //     Icons.call,
                      //     size: 30.0,
                      //   ),
                      // ),
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          // backgroundImage:
                          // NetworkImage('https://www.google.com/search?q=image+profile+icon&rlz=1C5CHFA_enIN944IN944&sxsrf=ALiCzsZUHh09ogAU7d2JkP0-BwAo9Ba-0Q%3A1671513272371&ei=uEShY-LXFcya4-EPhbySqAc&ved=0ahUKEwjik9iWuIf8AhVMzTgGHQWeBHUQ4dUDCA8&uact=5&oq=image+profile+icon&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCAAQgAQyBggAEBYQHjIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjIICAAQFhAeEAoyBggAEBYQHjIGCAAQFhAeMgYIABAWEB4yCAgAEBYQHhAPOgoIABBHENYEELADOgcIABCwAxBDOgQIIxAnOgUIABCGAzoQCAAQgAQQhwIQsQMQgwEQFDoLCAAQgAQQsQMQgwE6CAgAEIAEELEDOgUIABCRAjoNCAAQgAQQsQMQgwEQCjoHCAAQgAQQCjoKCAAQFhAeEA8QCkoECEEYAEoECEYYAFCUC1jsM2CPNWgDcAF4AIABwQSIAc8bkgEMMC4xMi4xLjAuMi4xmAEAoAEByAEKwAEB&sclient=gws-wiz-serp#imgrc=KGmmZKqVH-I6eM'),
                        ),
                      ),
                      // CircleAvatar(
                      //   backgroundColor: Strings.primaryColor,
                      //   minRadius: 35.0,
                      //   child: Icon(
                      //     Icons.message,
                      //     size: 30.0,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    currentUser.name,
                    style: Styles.poppinsBold,
                  ),
                  // Text(
                  //   currentUser.designation,
                  //   style: Styles.poppinsBold.copyWith(fontSize: 20),
                  // ),
                  // Text(
                  //   currentUser.employeeid,
                  //   style: Styles.poppinsBold.copyWith(fontSize: 20),
                  // ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      Strings.employeeCode,
                      style: TextStyle(
                        color: Strings.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      currentUser.employeeid,
                      style: Styles.poppinsBold
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(
                        color: Strings.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      currentUser.email,
                      style: Styles.poppinsBold
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Phone',
                      style: TextStyle(
                        color: Strings.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      currentUser.mobile,
                      style: Styles.poppinsBold
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Date Of Joining',
                      style: TextStyle(
                        color: Strings.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      UserModelCtrl.stateUserModel.last.data[0].joiningdate
                          .toString(),
                      style: Styles.poppinsBold
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Reporting Employee',
                      style: TextStyle(
                        color: Strings.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      GetUserData().getReportingPerson(),
                      style: Styles.poppinsBold
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Divider(),
                  // ListTile(
                  //   title: Text(
                  //     'Linkedin',
                  //     style: TextStyle(
                  //       color: Strings.primaryColor,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   subtitle: Text(
                  //     'www.linkedin.com/in/leonardo-palmeiro-834a1755',
                  //     style: Styles.poppinsBold.copyWith(color: Colors.black,fontSize: 15),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
