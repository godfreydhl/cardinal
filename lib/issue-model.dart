

import 'package:cloud_firestore/cloud_firestore.dart';

class Issue{

  final String title;
  final String image;
  final String price;
  final String file;
  final String thumbnail;
  final String preview_vid;
  final String date;
  final String about;
  final DocumentReference reference;

  Issue( this. reference,{
    required this.title,
    required this.image,
    required this.price,
    required this.file,
    required this.preview_vid,
    required this.date,
    required this.about,
    required this.thumbnail});

  Issue.fromMap(Map<String, dynamic> map, {required this.reference}):
        assert(map['title'] !=null),
        assert(map['image'] !=null),
        assert(map['price'] !=null),
        assert(map['file'] !=null),
        assert(map['preview_vid'] !=null),
        assert(map['date'] !=null),
        assert(map['about'] !=null),
        assert(map['thumbnail'] !=null),
        title = map['title'],
        image = map['image'],
        price = map['price'],
        file = map['file'],
        preview_vid = map['preview_vid'],
        date = map['date'],
        about = map['about'],
        thumbnail = map['thumbnail'];

  Issue.fromSnapshot(DocumentSnapshot snapshot):
      this.fromMap(snapshot.data()!, reference: snapshot.reference);





  String get tag => title;


  bool get isValid => title != null && price !=null && image !=null && file!=null;


}