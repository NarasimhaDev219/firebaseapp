import 'package:firebase_app/dash_bord.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _email, _password;
  var _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login"),
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
                                    borderRadius: BorderRadius.circular(30)
                                  )),
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
                                    borderRadius: BorderRadius.circular(30)
                                  )),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              child: RaisedButton(
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                color: Colors.blue,
                                onPressed: () {
                                  login();
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Register Your Account")))
                          ],
                        )),
                  ),
              ),
            ),
      ),
    );
  }

  void login() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        setState(() {
          isLoading = false;
        });

        Fluttertoast.showToast(msg: "Login Successfull");

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => DashBordMain()),
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
