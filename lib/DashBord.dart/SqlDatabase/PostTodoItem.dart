import 'package:firebase_app/DashBord.dart/SqlDatabase/db_helper.dart';
import 'package:firebase_app/DashBord.dart/SqlDatabase/to_do_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostTodoItem extends StatefulWidget {
  ToDoModel toDoModel;
  String appBaTitle;
  PostTodoItem(this.toDoModel, this.appBaTitle);

  @override
  _PostTodoItemState createState() =>
      _PostTodoItemState(this.toDoModel, this.appBaTitle);
}

class _PostTodoItemState extends State<PostTodoItem> {
  ToDoModel toDoModel;
  String appBaTitle;
  var _statusList = ["Pending", "Completed"];
  var _selectedStatus = "Pending";

  TextEditingController title_ed_Controller = new TextEditingController();
  TextEditingController desc_ed_Controller = new TextEditingController();

  _PostTodoItemState(this.toDoModel, this.appBaTitle);

  @override
  void initState() {
    // it will use when we update data to able to change atatus pending/Completed
    _selectedStatus =
        toDoModel.status.length == 0 ? "Pending" : toDoModel.status; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //receve data for update
    title_ed_Controller.text = toDoModel.title;
    desc_ed_Controller.text = toDoModel.description;
    

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(appBaTitle),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            //Padding(padding: EdgeInsets.symmetric(horizontal: 50)),
            DropdownButton(
                value: _selectedStatus,
                items: _statusList.map((item) {
                  return DropdownMenuItem(
                    child: Text(item),
                    value: item,
                  );
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    _selectedStatus = item;
                  });
                }),

            SizedBox(
              height: 50,
            ),

            TextField(
              controller: title_ed_Controller,
              decoration: InputDecoration(
                  hintText: "Enter Title",
                  labelText: "Title",
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              controller: desc_ed_Controller,
              decoration: InputDecoration(
                  hintText: "Enter Description",
                  labelText: "Description",
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 35),

            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  validate();
                },
                child: Text(
                  appBaTitle,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validate() {
    toDoModel.title = title_ed_Controller.text;
    toDoModel.description = desc_ed_Controller.text;
    toDoModel.status = _selectedStatus;
    toDoModel.date = DateFormat.yMMMEd().format(DateTime.now());

     DatBaseHelper dataBaseHelper = DatBaseHelper();

    if (toDoModel.id == null) 
    dataBaseHelper.insert(toDoModel);
    else
    dataBaseHelper.upDateData(toDoModel);

    title_ed_Controller.clear();
    desc_ed_Controller.clear();
    Navigator.pop(context, true);
  }
}
