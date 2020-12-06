import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/AuthSceens/SignupScreen.dart';
import 'package:firebase_app/DashBord.dart/FireBase/UploadStatus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  String page_title;

  HomeScreen(this.page_title);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseAuth.instance.onAuthStateChanged.listen((firebaseuser) {
  //     if (firebaseuser == null) {
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (_) => SignupScreen()),
  //           (Route<dynamic> rr) => false);
  //     } else {
  //       //if alredy login
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {

      Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home Screen"),
      //   actions: [
      //     PopupMenuButton(
      //         onSelected: (item) {
      //           if (item == "Logout") showAlertDialog(context);
      //         },
      //         itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      //               PopupMenuItem(value: "Logout", child: Text("Logout")),
      //             ])
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => UploadStatus()));
        },
        child: Icon(Icons.add_a_photo),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("statuses").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data.documents.length == 0) {
              return Text("Data not Available");
            }

            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  print("++++++++++++++++++++++++++++++ ===  $index");
                  return Card(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              snapshot.data.documents[index].data()["imageURL"],
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                snapshot.data.documents[index].data()["title"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data.documents[index]
                                    .data()["description"],
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  showAlertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Slect One"),
      content: Text("Are you sure you want LogOut"),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Flexible(
            flex: 10,
              child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Route route = MaterialPageRoute(
                            builder: (context) => SignupScreen());
                        Navigator.pushReplacement(context, route);
                      });
                    },
                    child: Text(
                      "yes",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    )),
                SizedBox(
                  width: 40,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    )),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
  
}
