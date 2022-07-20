import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  String title;
  AppBarTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: IconButton(
              color: Colors.blueGrey,
              icon: Icon(Icons.menu),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Container(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey,fontSize: 17.0),
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.language),
              color: Colors.blueGrey,
              onPressed: (){

              },
            ),
          ),
        ],
      ),
    );
  }
}
