import 'package:flutter/material.dart';
import '../screens/detail_items/detail_items.dart';


class CustomCard extends StatelessWidget {

  const CustomCard({
    Key key
  }): super(key: key);

  Future<DetailItems> navigateDetailItemPage(BuildContext context, String valueToPass) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailItems(),
        settings: RouteSettings(arguments: valueToPass)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "In stocks",
            style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DetailCard(
                makeModel: "BMW S1000RR",
                image: "assets/images/ca-map-BMW-S1000RR.jpg",
                count: 55,
                press: () {navigateDetailItemPage(context, "BMW S1000RR");},
              ),
              DetailCard(
                makeModel: "Kawasaki H2R",
                image: "assets/images/h2r.jpg",
                count: 23,
                press: () {navigateDetailItemPage(context, "Kawasaki H2R");},
              ),
              DetailCard(
                makeModel: "Honda CBR1000",
                image: "assets/images/HONDA_CBR1000RR.jpg",
                count: 42,
                press: () {navigateDetailItemPage(context, "Honda CBR1000");},
              ),
              DetailCard(
                makeModel: "Yamaha R1",
                image: "assets/images/yamaha_r1.jpg",
                count: 18,
                press: () {navigateDetailItemPage(context, "Yamaha R1");},
              ),
              SizedBox(width: 15)
            ],
          ),
        ),
      ],
    );
  }
}

class DetailCard extends StatelessWidget {

  final String image, makeModel;
  final int count;
  final GestureTapCallback press;

  const DetailCard({
    Key key,
    @required this.image,
    @required this.count,
    @required this.makeModel,
    @required this.press,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 300,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(image, fit: BoxFit.fill),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, 
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15)
                      ]
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$makeModel\n",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: "$count Availables")
                      ]
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
