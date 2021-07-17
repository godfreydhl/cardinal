import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'preview-video-view.dart';
import 'issue-model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

enum DownloadState{
  downloaded,
  downloading,
  notDownloaded,
}

class BuildButton extends StatelessWidget{

  BuildButton({

    required this.issue,
    required this.downloadState,
    required this.downloadButton,
    required this.startDownload,
    required this.openButton
  });

  final Issue issue;
  final DownloadState downloadState;
  final Widget Function(Issue issue) downloadButton;
  final Widget Function(Issue issue) startDownload;
  final Widget Function(Issue issue) openButton;

  @override
  Widget build(BuildContext context) {
    switch(downloadState){
      case DownloadState.notDownloaded:
        return downloadButton(issue);
      case DownloadState.downloading:
        return startDownload(issue);
      case DownloadState.downloaded:
        return openButton(issue);
    }
  }



}

class ButtonState extends ChangeNotifier{

  DownloadState downloadState = DownloadState.notDownloaded;

  Widget downloadButton(Issue issue){
    return Container(
      padding: const EdgeInsets.only(left:16, top: 8),
      child: ElevatedButton(
        onPressed: (){
          downloadState = DownloadState.downloading;
          notifyListeners();
          },
        child: Text(
          '  BUY NOW  ',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),

      ),
    );


  }

  Widget openButton (Issue issue){
    return Container(
      padding: const EdgeInsets.only(left:16, top: 8),
      child: ElevatedButton(
        onPressed: null
          /*() {Navigator.push(context, MaterialPageRoute(
                                builder: (_){
                                  return PdfView(issue: issue);
                                })
                              );
                            },*/
        ,
        child: Text(
          '  OPEN  ',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        ),

      ),
    );
  }



  Widget startDownload(Issue issue) {


    Future<Directory> Dir = getApplicationDocumentsDirectory();

    return FutureBuilder<Directory>(
        future: Dir,
        builder: (BuildContext context, AsyncSnapshot<Directory> snapshot){
          if (snapshot.hasData){

            File downloadFile = File('${snapshot.data!.path}/${issue.title}.pdf');
            firebase_storage.DownloadTask task = firebase_storage.FirebaseStorage
                .instance
                .ref('${issue.file}').writeToFile(downloadFile);
            return StreamBuilder<firebase_storage.TaskSnapshot>(
              stream: task.snapshotEvents,
              builder: (BuildContext context,AsyncSnapshot<firebase_storage.TaskSnapshot> streamSnapshot){
                if(streamSnapshot.hasError){
                  return Center(
                    child:Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  );
                }
                if(streamSnapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                      value: streamSnapshot.data!.bytesTransferred/streamSnapshot.data!.totalBytes
                  ),
                );
              },
            );
          }
          else return Center(child: CircularProgressIndicator(strokeWidth: 0.3));

        }
    );
  }

}