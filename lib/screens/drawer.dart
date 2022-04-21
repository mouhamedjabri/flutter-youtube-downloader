import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5,bottom: 20),
              child: Expanded(
                child: Text(
                  "Youtube\nDownloader",
                  style: TextStyle(color: Colors.white,fontSize: 28),
                ),
              ),
            ),  
          ),
          Card(
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.home,size: 40,),
              title: Text("HOME",style: TextStyle(fontSize: 19),),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.account_box,size: 40,),
              title: Text("ABOUT",style: TextStyle(fontSize: 19),),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.policy,size: 40,),
              title: Text("POLICY",style: TextStyle(fontSize: 19),),
            ),
          ),
        ],
      ),
    ));
  }
}
