import 'package:firebase_app/DashBord.dart/RetrifitGetData/photoModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServerImagesList extends StatefulWidget {
  @override
  _ServerImagesListState createState() => _ServerImagesListState();
}

class _ServerImagesListState extends State<ServerImagesList> {
  List<PhotoModel> modelList = List();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //it you want loading button use below code
      // _isLoading ?  CircularProgressIndicator() :
      //_isLoading ?  Center(child: CircularProgressIndicator()) : 
      body: ListView.builder(
          itemCount: modelList.length,
          itemBuilder: (BuildContext context, position) {
            return Card(
              color: Colors.blue,
              margin: EdgeInsets.all(10),
                child: ListTile(
                title: Text("${modelList[position].title}",style: TextStyle(color: Colors.white),),
                leading: Image.network("${modelList[position].thumbnailUrl}"),
              ),
            );
          }),
    );
  }

  void fetchData() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/photos");
    //decode data
    var dataList = await json.decode(data.body) as List;
    // send data server to model class
    modelList = dataList.map((item) => PhotoModel.fromJson(item)).toList();
    setState(() {
      _isLoading = true;
    });
  }
}
