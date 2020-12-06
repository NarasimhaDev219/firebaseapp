import 'package:firebase_app/DashBord.dart/Trending/SModel.dart';
import 'package:flutter/material.dart';

class TrendingList extends StatefulWidget {
  @override
  _TrendingListState createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
    final List<SModel> carsList = SModel.aArray();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: getCasList(context),
      ),
    );
  }
  getCasList(BuildContext context) {
    return ListView.builder(
        itemCount: carsList.length,
        itemBuilder: (BuildContext context, int position) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                        "images/" + carsList[position].image,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 130,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(     
                        crossAxisAlignment: CrossAxisAlignment.start,             
                        children: [
                          Text(carsList[position].title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text(carsList[position].desciption,style: TextStyle(fontSize: 11,color: Colors.grey),)
                        ],

                      ),
                    )
                    
                  ],
                  
                ),
              ),
            ),
          );
        });
  }

}