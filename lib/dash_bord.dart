import 'package:firebase_app/AuthSceens/SignupScreen.dart';
import 'package:firebase_app/DashBord.dart/Chats/ChatScreen.dart';
import 'package:firebase_app/DashBord.dart/FireBase/HomeScreen.dart';
import 'package:firebase_app/DashBord.dart/RetrifitGetData/ServerImages.dart';
import 'package:firebase_app/DashBord.dart/SqlDatabase/DataBaseScreen.dart';
import 'package:firebase_app/DashBord.dart/Trending/Trending.dart';
import 'package:firebase_app/SideNavigationScreens/PlayVideoClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashBordMain extends StatefulWidget {
  @override
  _DashBordMainState createState() => _DashBordMainState();
}

class _DashBordMainState extends State<DashBordMain> {
  var drawer_list = [
    Center(
      child: Text("This is Home Screen"),
    ),
    Center(
      child: Text("This is Profile Screen"),
    ),
    Center(
      child: Text("This is Subscriptions"),
    ),
    Center(
      child: Text("This is History"),
    )
  ];

  var data = [
    //if you have more data eplace to Text to Caffold wedget
    Container(child: HomeScreen("FireBase")),
    Container(child: ServerImagesList()),
    Container(child: DataBaseScreen()),
    Container(child: TrendingScreen()),
    Container(child: ChatsScreen()),
  ];

  int item_position = 0;
  int current_position = 2;
  String page_title = null;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseuser) {
      if (firebaseuser == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SignupScreen()),
            (Route<dynamic> rr) => false);
      } else {
        //if alredy login
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.open_in_browser,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebView(
                                initialUrl: "https://flutter.dev/",
                                javascriptMode: JavascriptMode.unrestricted,
                              )));
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewExample()));
                }),
            PopupMenuButton(
                onSelected: (item) {
                  if (item == "Settings")
                    print("Settings Item Selected");
                  else
                    showAlertDialog(context);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        child: Text("Settings"),
                        value: "Settings",
                      ),
                      PopupMenuItem(
                        child: Text("Logout"),
                        value: "Logout",
                      ),
                    ])
          ],
          iconTheme: new IconThemeData(color: Colors.white),
          //centerTitle: true,
          title: Container(
            child: Text(
              "DashBord",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        drawer: new Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Column(
                  children: [
                    Image.network(
                      "https://i.pinimg.com/originals/2d/3b/54/2d3b5459e7bc6eefd6361685601290a4.jpg",
                      height: 120,
                      width: 120,
                    )
                  ],
                ),
              )),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Videos"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PlayVideoScreen()));
                  setState(() {
                    item_position = 0;
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Google Maps"),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => MyMapsActivity()));
                  setState(() {
                    item_position = 1;
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.subscriptions),
                title: Text("Subscriptions"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    item_position = 2;
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("Chats"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    item_position = 3;
                  });
                },
              ),
            ],
          ),
        ),
        // body: drawer_list[item_position],
        body: Center(child: data[current_position]),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: current_position,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.fireplace),
              title: Text(
                "Firebase",
                style: TextStyle(fontSize: 10),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up),
                title: Text(
                  "Retrofit",
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo),
                title: Text(
                  "SQL DataBase",
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text(
                  "Trending",
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_add),
                title: Text(
                  "Chats",
                  style: TextStyle(fontSize: 10),
                )),
          ],
          onTap: (index) {
            setState(() {
              current_position = index;
            });
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Slect One"),
      content: Text("Are you sure you want LogOut"),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
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

// class WebViewExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebView(
//         initialUrl: "https://flutter.dev/",
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }
