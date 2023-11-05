// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DisplayFiles extends StatefulWidget {
  final Pet pet;
  final String subject;
  const DisplayFiles({Key? key, required this.pet, required this.subject})
      : super(key: key);

  @override
  State<DisplayFiles> createState() => _DisplayFilesState();
}

class _DisplayFilesState extends State<DisplayFiles> {
  late Future<ListResult> futureFiles;
  late String? petId = widget.pet.referenceId;
  late String subject = widget.subject;
  Map<int, double> downloadProgress = {};
  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('$subject/$petId').list();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final files = snapshot.data!.items;
              return ListView.separated(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  final fileName = file.name;
                  double? progress = downloadProgress[index];
                  return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              Text('Delete',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Confirmation"),
                                content: const Text(
                                    "Are you sure you want to delete this document?"),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("Delete")),
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      onDismissed: (direction) async {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$fileName deleted')));

                        final tempDir = await getTemporaryDirectory();
                        print("linoy print: " + file.fullPath);
                        FirebaseStorage.instance
                            .refFromURL(
                                'gs://pet-health-app-a25bc.appspot.com/' +
                                    file.fullPath)
                            .delete();
                      },
                      child: ListTile(
                        title: Text(file.name),
                        subtitle: progress != null
                            ? LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.black26,
                              )
                            : null,
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.download,
                            color: Colors.black,
                          ),
                          onPressed: () => downloadFile(index, file),
                        ),
                      ));
                },
                separatorBuilder: (context, index) => Divider(
                  height: 2.0,
                  color: Colors.black87,
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error occured by trying display your docs'),
              );
            } else {
              return const Center(
                child: Text(""),
              );
            }
          }),
    );
  }

  Future downloadFile(int index, Reference ref) async {
    //final dir = await getApplicationDocumentsDirectory();
    //final file = File('${dir.path}/${ref.name}');

    //await ref.writeToFile(file)
    final url = await ref.getDownloadURL();

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(
      url,
      path,
      onReceiveProgress: (recived, total) {
        double progress = recived / total;

        setState(() {
          downloadProgress[index] = progress;
        });
      },
    );

    //await FileSaver.instance.saveFile(path, );
    //await ImageGallerySaver.saveFile(path);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded ${ref.name}')),
    );
  }
}
