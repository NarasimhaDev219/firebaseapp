import 'package:firebase_app/AuthSceens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/animation.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _email, _password;
  var _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("SignUp"),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              onChanged: (item) {
                                setState(() {
                                  _email = item;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              validator: (text) {
                                return text.contains("@")
                                    ? null
                                    : "Enter valid Email";
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter Your Email",
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              onChanged: (item) {
                                setState(() {
                                  _password = item;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              validator: (text) {
                                return text.length > 6
                                    ? null
                                    : "Password Must Be 6 Characters";
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter Password",
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: Colors.blue,
                                onPressed: () {
                                  signup();
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(pageRouteNavigator(LoginScreen()));
                                      
                                    },
                                    child: Text(
                                      "Login Your Account",
                                      style: TextStyle(fontSize: 15),
                                    )))
                          ],
                        )),
                  ),
                ),
              ),
      ),
    );
  }

  void signup() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Error" + onError).toString();
      });
    }
  }
}

Route pageRouteNavigator(Widget widget) {
  return PageRouteBuilder(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secAnimation) {
      return widget;
    },
    transitionsBuilder: (context, animation, secAnimation, widget) {
      //  animation = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
      return SlideTransition(
        position:
            Tween<Offset>(
              begin: const Offset(2.0, 0.0),
               end: Offset.zero)
                .animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(2.0, 0.0),
          ).animate(secAnimation),
          child: widget,
        ),
      );
    },
  );
}

//  return ScaleTransition(
//           alignment: Alignment.center,
//           scale: animation,
//           child: widget,
//         );
