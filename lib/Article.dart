import 'package:cloud_firestore/cloud_firestore.dart';

class Article{


  final String title;
  final String content;
  final String image;
  final String type;
  final DocumentReference reference;

  Article(this.reference,{
    required this.title,
    required this.image,
    required this.content,
    required this.type
  });

  Article.fromMap(Map<String, dynamic> map, {required this.reference}):
        assert(map['title'] != null),
        assert(map['content'] != null),
        assert(map['image'] != null),
        assert(map['type'] != null),
        title = map['title'],
        image = map['image'],
        type = map['type'],
        content = map['content'];



  Article.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data()!, reference: snapshot.reference);


  DateTime _dateBookmarked= DateTime.now();
  DateTime get dateBookmarked => _dateBookmarked;

  set dateBookmarked(DateTime value){
    _dateBookmarked = value;
  }



  bool isBookmarked = false;
  String get tag => title;
  bool get bookmark => isBookmarked;

  bool get isValid => title != null && content !=null && image !=null;


}