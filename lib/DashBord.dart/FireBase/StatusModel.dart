class StatusModel {
  //this Model is used to send items to Firebase Storage
  String docid;
  String imageURL;
  String title;
  String description;

  StatusModel({this.docid, this.imageURL, this.title, this.description});

  toMap() {
    Map<String, dynamic> map = Map();

    map['docid'] = docid;
    map['imageURL'] = imageURL;
    map['title'] = title;
    map['description'] = description;
    return map;
  }
}
