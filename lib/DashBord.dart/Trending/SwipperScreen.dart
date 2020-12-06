import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwipperScreen extends StatefulWidget {
  final String title;
  SwipperScreen({Key key, this.title}) : super(key: key);

  @override
  _SwipperScreenState createState() => _SwipperScreenState();
}

class _SwipperScreenState extends State<SwipperScreen> {
  final imageList = [
    "images/restaurent1.jpg","images/restaurent2.jpg","images/restaurent3.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 150,
      decoration: BoxDecoration(boxShadow: [
        //BoxShadow(color: Colors.green, spreadRadius: 3),
      ], borderRadius: BorderRadius.circular(30)),
      width: double.infinity,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              new Swiper(
                itemBuilder: (BuildContext context, int position) {
                  return Container(
                    // decoration: new BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     image: new DecorationImage(
                    //         image: AssetImage(imageList[position]),
                    //         fit: BoxFit.fill)),
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: imageList.length,
                autoplay: true,
                //duration: Duration()
                itemHeight: 130,
                itemWidth: double.infinity,
                pagination: new SwiperPagination(),
                layout: SwiperLayout.STACK,
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
