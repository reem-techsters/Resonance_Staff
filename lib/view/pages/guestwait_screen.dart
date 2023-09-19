import 'package:attendance/constant/strings.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Guestscreen extends StatefulWidget {
  const Guestscreen({super.key});

  @override
  State<Guestscreen> createState() => _GuestscreenState();
}

class _GuestscreenState extends State<Guestscreen> {
  @override
  Widget build(BuildContext context) {
    double width = Strings.width(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: CustomDrawer2(),
        backgroundColor: Strings.bgColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 150,
                    child: Image.asset("assets/icon/Group 1841@2x.png")),
                SizedBox(height: 10),
                Text(
                  'Waiting for Admin Approval',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Please wait for the admin to approve your request.It may take time.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
