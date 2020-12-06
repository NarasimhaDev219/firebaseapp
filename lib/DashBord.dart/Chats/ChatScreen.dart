import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  String selectedCountry = "+91";
  TextEditingController _numberController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        key: _globalKey,
        // appBar: AppBar(
        //   title: Text("Chats Screen"),
        // ),
        body: SingleChildScrollView(
                  child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Text Me",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue[600]),),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Expanded(
                      flex: 20,
                      child: CountryCodePicker(
                        initialSelection: "IN",
                        favorite: ["+91", "IN"],
                        onChanged: (item) {
                          print("Country Code :" + item.dialCode);
                          setState(() {
                            selectedCountry = item.dialCode;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 80,
                      child: TextField(
                        minLines: 1,
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                            hintText: "Mobile Number",
                            labelText: "Phone",
                            border: OutlineInputBorder()),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 100,
                  child: TextField(
                    controller: _messageController,
                    minLines: 3,
                    maxLines: 1000,
                    decoration: InputDecoration(
                        hintText: 'Type Your Message',
                        labelText: 'Message',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                   // color: Colors.blue,
                    onPressed: () {
                      SendMessage();
                       _messageController.clear();
                       _numberController.clear();
                    },
                    child: Text(
                      "Send",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void SendMessage() {
    String _number, _message;

    if (_numberController == null || _numberController.text.length < 10) {
      _globalKey.currentState
          .showSnackBar(SnackBar(content: Text("Enter valid mobile number")));
      return;
    }

    _number = selectedCountry + _numberController.text;
    _message = _messageController.text;
    //String chat_url ="https://wa.me/$_number?text="+Uri.encodeComponent(_message);
    String chat_url =
        "https://wa.me/$_number?text=" + Uri.encodeComponent(_message);
    _launchURL(chat_url);
   
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
