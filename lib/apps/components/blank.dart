import 'package:flutter/material.dart';

class Blank extends StatelessWidget {
  String text;
  double width;
  double height;
  Blank({
    @required this.text
    ,@required this.height
    ,@required this.width}):super();

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width,
            child: Image.asset('assets/nodata.png'),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height*0.3,
            width: width,
            color: Colors.white,
            child: Text(text,style: TextStyle(
                fontSize: 16,color: Colors.black54),),
          ),
//          Positioned(
//            top: height/2.1,
//            child: Expanded(child:
//            Text(text,style: TextStyle(fontWeight: FontWeight.bold
//                ,fontSize: 18,color: Colors.black54),)
//            ),
//          )
        ],
      ),
    );
  }
}
