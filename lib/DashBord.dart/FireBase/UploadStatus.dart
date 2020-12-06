import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/DashBord.dart/FireBase/StatusModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadStatus extends StatefulWidget {
  @override
  _UploadStatusState createState() => _UploadStatusState();
}

class _UploadStatusState extends State<UploadStatus> {
  File _imageFile = null;
  bool _isLoading = false;

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Upload to firebase"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
            child: SingleChildScrollView(
                   scrollDirection: Axis.vertical,
                    child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        _imageFile == null
                            ? Text("Image not Found")
                            : Image.file(
                                _imageFile,
                                height: 200,
                                width: double.infinity,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          height: 40,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.blue,
                            onPressed: () {
                              pickImage();
                            },
                            child: Text(
                              "Get Image From Storage",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            controller: titleEditingController,
                            decoration: InputDecoration(
                                hintText: "Enterr Title",
                                labelText: "Title",
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: TextField(
                            controller: descriptionEditingController,
                            minLines: 2,
                            maxLines: 10,
                            decoration: InputDecoration(
                                hintText: "Enter Description",
                                labelText: "Description",
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          height: 40,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.blue,
                            onPressed: () {
                              uploadStatus();
                            },
                            child: Text(
                              "Upload Status",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
            ),
          ),
            
    );
  }

  Future<dynamic> pickImage() async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = file;
    });
  }

  uploadStatus() async {

    setState(() {
      _isLoading = true;
    });

    var uploadimg = await uploadImageToFirebase();
    StatusModel statusModel = new StatusModel();
    statusModel.imageURL = uploadimg.toString();
    statusModel.title = titleEditingController.text;
    statusModel.description = descriptionEditingController.text;

    String docID =
        Firestore.instance.collection("statuses").document().documentID;
    statusModel.docid = docID;

    await Firestore.instance
        .collection("statuses")
        .document(statusModel.docid)
        .setData(statusModel.toMap());

    Fluttertoast.showToast(msg: "Status Uploaded");
    Navigator.pop(context);

    setState(() {
      _isLoading = false;
    });
  }

  uploadImageToFirebase() async {
    Reference storagereference =
        await FirebaseStorage().ref().child("statuses");

    TaskSnapshot uploadTask = await storagereference
        .child(DateTime.now().toIso8601String())
        .putFile(_imageFile);
    var downloadURL = await uploadTask.ref.getDownloadURL();
    print("downloadURL ===== $downloadURL");
    Fluttertoast.showToast(msg: "Image Uploaded to Firebase");
    return downloadURL;
  }
}
