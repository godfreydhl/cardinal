import 'Article-model.dart';
import 'Article-list-temp.dart';
import 'package:flutter/material.dart';

class BookmarkIcon extends StatefulWidget{

  _BookmarkIconState createState() => _BookmarkIconState();
  final Article article;
  final Color color;

  BookmarkIcon(this.article, this.color);


}

class _BookmarkIconState extends State<BookmarkIcon>{
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.article.isBookmarked? Icon(Icons.bookmark) :Icon(Icons.bookmark_border),
      color: widget.color,

      onPressed:(){
        setState(() {
          if(widget.article.isBookmarked){
            widget.article.isBookmarked = false;
          }
          else{
            widget.article.isBookmarked = true;
          }
        });
        debugPrint('share, ${widget.article.title}, ${widget.article.isBookmarked}');

      },
    );


  }

}
