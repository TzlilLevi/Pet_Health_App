import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/forum/post_view.dart';
import 'package:pet_health_app/models/post.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/repository/data_repository.dart';

class CardPostForum extends StatefulWidget {
  final Post post;
  final String splittedEmail;
  final String forumName;
  const CardPostForum(
      {Key? key,
      required this.post,
      required this.splittedEmail,
      required this.forumName})
      : super(key: key);
  @override
  _CardPostForumState createState() => _CardPostForumState();
}

class _CardPostForumState extends State<CardPostForum> {
  late String? _id;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    late DateFormat dateFormat = DateFormat.yMMMMd();

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
          shape:
              //StadiumBorder(side: BorderSide(width: 1, color: Colors.black54, )),
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: Colors.grey.withOpacity(0.5), width: 1)),
          color: Colors.white,
          child: InkWell(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Text(
                            widget.post.headline,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    ),
                    //Spacer(),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 46.0),
                          child: Text(
                            dateFormat.format(widget.post.date),
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          )),
                    ),

                    //_getPetIcon(pet.type)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.red,
                                size: 17,
                              ),
                            ),
                            TextSpan(
                                text: "   " + widget.post.likesCount.toString(),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                )),
                          ]),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(
                                FontAwesomeIcons.comment,
                                color: Colors.blueAccent,
                                size: 17,
                              ),
                            ),
                            TextSpan(
                                text: "   " +
                                    widget.post.comments!.length.toString(),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                )),
                          ]),
                        )),

                    //_getPetIcon(pet.type)
                  ],
                ),
              ],
            ),
            onTap: () async {
              if (widget.post.likes == null ||
                  !widget.post.likes!.containsKey(widget.splittedEmail)) {
                await FirebaseFirestore.instance
                    .collection('Forum' + widget.forumName)
                    .doc(widget.post.referenceId)
                    .update({
                  'likes.$widget.splittedEmail': 0,
                });
              }
              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PostView(post: widget.post, forumName: widget.forumName),
                ),
              );
            },
            onLongPress: () => {
              setState(() {
                _id = widget.post
                    .referenceId; //if you want to assign the index somewhere to check
              }),
              print(_id),
              if (auth.currentUser!.email == widget.post.userEmail)
                {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: new Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                              title: new Text('Edit'),
                              onTap: () async {
                                // Navigator.pop(context);
                                // editCommentController.text =
                                //     snapshot.data![_id].body;
                                // date = snapshot.data![_id].date;
                                // ListTile(
                                //     title: TextFormField(
                                //       key: _formKey,
                                //       controller: editCommentController,
                                //       decoration: InputDecoration(
                                //           labelText: "Edit a comment..."),
                                //     ),
                                //     trailing: IconButton(
                                //       icon: Icon(Icons.send),
                                //       onPressed: () async {
                                //         //if (_formKey.currentState?.validate() ?? false) {
                                //         Navigator.of(context);
                                //         final newComment = Comment(
                                //           userEmail: auth.currentUser!.email!,
                                //           body: editCommentController.text,
                                //           date: DateTime.now(),
                                //         );
                                //         post.comments!.add(newComment);
                                //         repository.updatePost(
                                //             widget.post, widget.forumName);
                                //         editCommentController.clear();
                                //         // }
                                //         //widget.callback();
                                //       },
                                //     ));
                              },
                            ),
                            ListTile(
                              leading: new Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                              title: new Text('Delete'),
                              onTap: () async {
                                Navigator.pop(context);
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('Forum' + widget.forumName)
                                      .doc(widget.post.referenceId)
                                      .delete();
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                          ],
                        );
                      })
                }
            },
            splashColor: Colors.blue,
          )),
    );
  }
}
