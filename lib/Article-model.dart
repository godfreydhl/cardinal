

class Article{

  Article({
    this.title,
    this.image,
    this.content
  });

  final String title;
  final String content;
  final String image;

  bool isBookmarked = false;
  String get tag => title;
  bool get bookmark => isBookmarked;

  bool get isValid => title != null && content !=null && image !=null;


}