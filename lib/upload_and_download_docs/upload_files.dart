import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/repository/data_repository.dart';
import 'package:pet_health_app/toDo/firebase_api.dart';

class UploadFiles extends StatefulWidget {
  final Pet pet;
  final String subject;
  const UploadFiles({Key? key, required this.pet, required this.subject})
      : super(key: key);

  @override
  State<UploadFiles> createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  UploadTask? task;
  File? file;
  String? newFileOfMedicalDocs;
  final DataRepository repository = DataRepository();
  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'No document Selected';
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: selectFile,
                label: Text('Select Document'),
                icon: Icon(Icons.attach_file),
              ),
            ),
            SizedBox(height: 8),
            Text(
              fileName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: uploadFile,
                label: Text('Upload Documnet'),
                icon: Icon(Icons.cloud_upload_outlined),
              ),
            ),
            SizedBox(height: 20),
            task != null ? buildUploadStatus(task!) : Container(),
          ],
        )),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;
    final petId = widget.pet.referenceId;
    final subject = widget.subject;
    final fileName = basename(file!.path);
    print("File Name var print: " + fileName);
    final destination = '$subject/$petId/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload =
        await snapshot.ref.getDownloadURL().then((fileURL) => setState(() {
              newFileOfMedicalDocs = fileURL;
              // widget.pet.medicalDocs!.add(newFileOfMedicalDocs!);
              // repository.updatePet(widget.pet);
            }));

    //print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
