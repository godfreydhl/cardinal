

class Issue{

  Issue(this.title, this.image, this.price, this.file, this.preview_vid, this.date,this.about, this.thumbnail);

  final String title;
  final String image;
  final String price;

  final String file;
  final String thumbnail;
  final String preview_vid;
  final String date;
  final String about;

  String get tag => title;


  bool get isValid => title != null && price !=null && image !=null && file!=null;


}