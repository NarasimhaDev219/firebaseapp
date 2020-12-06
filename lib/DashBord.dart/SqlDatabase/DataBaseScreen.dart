import 'package:firebase_app/DashBord.dart/SqlDatabase/PostTodoItem.dart';
import 'package:firebase_app/DashBord.dart/SqlDatabase/db_helper.dart';
import 'package:firebase_app/DashBord.dart/SqlDatabase/to_do_model.dart';
import 'package:flutter/material.dart';


class DataBaseScreen extends StatefulWidget {
  @override
  _DataBaseScreenState createState() => _DataBaseScreenState();
}

class _DataBaseScreenState extends State<DataBaseScreen> {
  DatBaseHelper dataBaseHelper = DatBaseHelper();
  List<ToDoModel> modelData = null;
  int count = 0;

  GlobalKey<ScaffoldState> globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (modelData == null) {
      modelData = new List();
      upDateListView();
    }

    return Scaffold(
      key: globalKey,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "DataBase",
      //   ),
      // ),
      
      body: populateListView(),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationToDetailsView(ToDoModel("", "", "", ""), "Add NewItem");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //get Data from DataBase
  upDateListView() async {
    modelData = await dataBaseHelper.getModelsFromMapList();
    setState(() {
      modelData = modelData;
      count = modelData.length;
    });
  }

  ListView populateListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          ToDoModel toDoModel = this.modelData[index];
          return GestureDetector(
            onTap: () {
              navigationToDetailsView(toDoModel, "UpDate Data");
            },
            child: Card(
                margin: EdgeInsets.all(10),
                color: toDoModel.status == "Pending"
                    ? Colors.orange[300]
                    : Colors.blue[500],
                child: ListTile(
                  leading: toDoModel.status == "Pending"
                      ? Icon(
                          Icons.warning,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.done_all,
                          color: Colors.white,
                        ),
                  title: Text(toDoModel.title),
                  subtitle: Text(toDoModel.description),
                  //trailing: Icon(Icons.delete),
                  trailing: toDoModel.status == "Completed"
                      ? GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onTap: () {
                            deleteItemFromDB(toDoModel);
                          },
                        )
                      : null,
                  // trailing: toDoModel.status == "Completed" ? Icon(Icons.delete) : null,
                )),
          );
        });
  }

  deleteItemFromDB(ToDoModel toDoModel) {
    var results = dataBaseHelper.deleteData(toDoModel);
    if (results != 0) {
      globalKey.currentState.showSnackBar(SnackBar(
          content: Text(
        "item Deleted", 
        style: TextStyle(color: Colors.white),
      )));
      upDateListView();
    }
  }

  navigationToDetailsView(ToDoModel toDoModel, String appBarTitle) async {
    bool results =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PostTodoItem(toDoModel, appBarTitle);
    }));
    if (results) {
      //update list
      upDateListView();
    }
  }
}

