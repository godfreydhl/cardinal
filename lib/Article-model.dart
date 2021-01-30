

class Article{

  Article({
    this.title,
    this.image,
    this.content
  });

  final String title;
  final String content;
  final String image;

  bool _isBookmarked = false;

  bool get isBookmarked => _isBookmarked;

  set isBookmarked(bool value) {
    _isBookmarked = value;
  }

  String get tag => title;


  bool get isValid => title != null && content !=null && image !=null;


}