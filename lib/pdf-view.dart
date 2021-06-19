/*import 'package:flutter/material.dart';
import 'issue-model.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class PdfView extends StatelessWidget{

  PdfView({this.issue});
  final Issue issue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          child: PDF.assets(
            issue.file,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            placeHolder: Center(
              child: CircularProgressIndicator(
                key: null,
                value: null,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation <Color>(Colors.black),

              ),
            ),


          )
      ),
    );
  }

}*/