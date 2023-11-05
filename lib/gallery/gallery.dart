import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_health_app/repository/data_repository.dart';

class Gallery extends StatefulWidget {
  final Pet pet;
  const Gallery({Key? key, required this.pet}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late XFile? _imageFile;
  final picker = ImagePicker();
  List<String>? petGallery;
  String? newImageOfGallery;
  final DataRepository repository = DataRepository();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late Pet pet;

  Future pickImageCamera() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile;
    });
    await uploadImageToFirebase();
  }

  Future pickImageGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
    await uploadImageToFirebase();
  }

  Future uploadImageToFirebase() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    File? file = File(_imageFile!.path);
    Reference ref = storage.ref().child('gallery/${Path.basename(file.path)}}');
    UploadTask uploadTask = ref.putFile(file);
    await uploadTask;
    ref.getDownloadURL().then((fileURL) {
      setState(() {
        newImageOfGallery = fileURL;
        widget.pet.gallery!.add(newImageOfGallery!);
        repository.updatePet(widget.pet);
      });
    });
  }

  Future _uploadPhoto(mFileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("gallery");
    UploadTask uploadTask = storageReference
        .child("pet_$newImageOfGallery.jpg")
        .putFile(mFileImage);

    String url = await (await uploadTask).ref.getDownloadURL();
    newImageOfGallery = url;
  }

  @override
  void initState() {
    pet = widget.pet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _firebaseFirestore
              .collection("pet")
              .doc(pet.referenceId)
              .snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasError
                ? Center(
                    child: Text("There is some problem loading pet images"))
                : snapshot.hasData
                    ? GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        //childAspectRatio: (16 / 16),
                        children: snapshot.data!['gallery']
                            .map<Widget>((e) => InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                              content: Stack(
                                                  alignment: Alignment.center,
                                                  children: <Widget>[
                                                Image.network(
                                                  e,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                                // IconButton(
                                                //   color: Colors.grey,
                                                //   hoverColor: Colors.red,
                                                //   onPressed: () async {
                                                //     try {
                                                //       await FirebaseFirestore
                                                //           .instance
                                                //           .collection('pet')
                                                //           .doc(pet.referenceId)
                                                //           .update(
                                                //         {
                                                //           'gallery': FieldValue
                                                //               .arrayRemove(e)
                                                //         },
                                                //       );
                                                //     } catch (e) {
                                                //       print(e);
                                                //     }
                                                //   },
                                                //   icon: Icon(Icons.delete),
                                                // )
                                              ])));
                                },
                                child: Image.network(e)))
                            .toList(),
                      )
                    : Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                        leading: new Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                        title: new Text('Pick from gallery'),
                        onTap: pickImageGallery),
                    ListTile(
                        leading: new Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                        ),
                        title: new Text('Take a picture'),
                        onTap: pickImageCamera),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // _showPickOptionsDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 ListTile(
  //                     title: Text("Pick from Gallery"),
  //                     onTap: () {
  //                       _loadPicker(ImageSource.gallery);
  //                       //uploadImageToFirebase();
  //                     }),
  //                 ListTile(
  //                     title: Text("Take a picture"),
  //                     onTap: () async {
  //                       await _loadPicker(ImageSource.camera);
  //                       //uploadImageToFirebase();
  //                     })
  //               ],
  //             ),
  //           ));
  // }
}
