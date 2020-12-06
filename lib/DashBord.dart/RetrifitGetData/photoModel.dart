//https://jsonplaceholder.typicode.com/     for Apis

class PhotoModel {
  String title;
  String thumbnailUrl;

  PhotoModel({this.title, this.thumbnailUrl});

  factory PhotoModel.fromJson(Map<String, dynamic> map) {
    return PhotoModel(
        title: map["title"], thumbnailUrl: map["thumbnailUrl"]);
  }
}
