import 'package:firebase_app/DashBord.dart/Trending/SwipperScreen.dart';
import 'package:firebase_app/DashBord.dart/Trending/TrendingList.dart';
import 'package:flutter/material.dart';

class TrendingScreen extends StatefulWidget {
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwipperScreen(),
            Expanded(child: TrendingList()),
            // Text("Trending",style: TextStyle(fontSize: 25,color: Colors.blueAccent),)
          ],
        ),
      ),
    );
  }
}