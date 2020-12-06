class SModel {
  final String image;
  final String title;
  final String address;
  final String rating;
  final String views;
  final String desciption;

  SModel(this.image, this.title, this.address,this.rating,this.views,this.desciption);

  static List<SModel> aArray() {
    var data = List<SModel>();
    data.add(new SModel("restaurent1.jpg", "Bawarchi", "Hyderabad","4.1","234","?"));
    data.add(new SModel("restaurent2.jpg", "Venkatesh Grand", "Guntur","4.5","654",""));
    data.add(new SModel("restaurent3.jpg", "Grand Karthikeya", "Vijayada","3.1","12",""));
     data.add(new SModel("restaurent1.jpg", "Bawarchi", "Hyderabad","4.1","234","?"));
    data.add(new SModel("restaurent2.jpg", "Venkatesh Grand", "Guntur","4.5","654",""));
    data.add(new SModel("restaurent3.jpg", "Grand Karthikeya", "Vijayada","3.1","12",""));
     data.add(new SModel("restaurent1.jpg", "Bawarchi", "Hyderabad","4.1","234","?"));
    data.add(new SModel("restaurent2.jpg", "Venkatesh Grand", "Guntur","4.5","654",""));
    data.add(new SModel("restaurent3.jpg", "Grand Karthikeya", "Vijayada","3.1","12",""));
     data.add(new SModel("restaurent1.jpg", "Bawarchi", "Hyderabad","4.1","234","?"));
    data.add(new SModel("restaurent2.jpg", "Venkatesh Grand", "Guntur","4.5","654",""));
    data.add(new SModel("restaurent3.jpg", "Grand Karthikeya", "Vijayada","3.1","12",""));
     data.add(new SModel("restaurent1.jpg", "Bawarchi", "Hyderabad","4.1","234","?"));
    data.add(new SModel("restaurent2.jpg", "Venkatesh Grand", "Guntur","4.5","654",""));
    data.add(new SModel("restaurent3.jpg", "Grand Karthikeya", "Vijayada","3.1","12",""));
    
   
    return data;
  }
}
