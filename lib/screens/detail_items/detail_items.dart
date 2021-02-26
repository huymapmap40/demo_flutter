import 'package:flutter/material.dart';


class DetailItems extends StatelessWidget{

  static String routeName = "/detailitems";

  const DetailItems({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final String valueToPass = ModalRoute.of(context).settings.arguments;

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Hello $valueToPass", 
            textAlign: TextAlign.center, 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
