import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/forum/comment_list.dart';
import 'package:pet_health_app/models/comment.dart';
import 'package:pet_health_app/models/post.dart';
import 'package:intl/intl.dart';
import 'package:pet_health_app/repository/data_repository.dart';
//import 'package:firebase_encode/firebase_encode.dart';

class PostView extends StatefulWidget {
  final Post post;
  final String forumName;
  const PostView({Key? key, required this.post, required this.forumName})
      : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  TextEditingController commentController = TextEditingController();
  late Post post;
  late DateFormat dateFormat = DateFormat.yMMMMd();
  final DataRepository repository = DataRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late bool isClicked = false;
  late String userEmail;
  late List<String> splittedEmailList;
  late String splittedEmail;
  @override
  void initState() {
    post = widget.post;
    userEmail = auth.currentUser!.email!;
    splittedEmailList = userEmail.split('.');
    splittedEmail = splittedEmailList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text("Forum " + widget.forumName),
      ),
      body: StreamBuilder<Post>(
          stream: FirebaseFirestore.instance
              .collection('Forum' + widget.forumName)
              .doc(post.referenceId)
              .snapshots()
              .map((doc) => Post.fromJson(doc.data() ?? {})),
          builder: (context, snapshot1) {
            return StreamBuilder<List<Comment>>(
                stream: FirebaseFirestore.instance
                    .collection('Forum' + widget.forumName)
                    .doc(post.referenceId)
                    .snapshots()
                    .map((doc) => Post.fromJson(doc.data() ?? {}))
                    .map((post) => post.comments!),
                builder: (context, snapshot) {
                  if (snapshot.data == null)
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.teal),
                      ),
                    );
                  return Column(
                    //mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape:
                              //StadiumBorder(side: BorderSide(width: 1, color: Colors.black54, )),
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.grey.withOpacity(0.1),
                                      width: 0.5)),
                          color: Colors.white,
                          child: InkWell(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.post.headline,
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.post.body,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 2, 1, 2),
                                        child: Text("User:",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                            )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.post.userEmail,
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            dateFormat.format(post.date),
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          IconButton(
                                            icon: Icon(
                                              //isClicked
                                              snapshot1.data!.likes == null ||
                                                      snapshot1.data!.likes![
                                                              splittedEmail] ==
                                                          0
                                                  ? Icons.favorite_border
                                                  : Icons.favorite,

                                              color: Colors.red,
                                              size: 17,
                                            ),
                                            onPressed: () async => {
                                              if (snapshot1.data!.likes == null)
                                                {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Forum' +
                                                          widget.forumName)
                                                      .doc(post.referenceId)
                                                      .update({
                                                    'likes.$splittedEmail': 1,
                                                    'likesCount': snapshot1
                                                            .data!.likesCount +
                                                        1
                                                  }),
                                                }
                                              else if (!snapshot1.data!.likes!
                                                  .containsKey(splittedEmail))
                                                {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Forum' +
                                                          widget.forumName)
                                                      .doc(post.referenceId)
                                                      .update({
                                                    'likes.$splittedEmail': 1,
                                                    'likesCount': snapshot1
                                                            .data!.likesCount +
                                                        1
                                                  }),
                                                }
                                              else if (snapshot1.data!.likes!
                                                  .containsKey(splittedEmail))
                                                {
                                                  if (snapshot1.data!.likes![
                                                          splittedEmail] ==
                                                      1)
                                                    {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Forum' +
                                                              widget.forumName)
                                                          .doc(post.referenceId)
                                                          .update({
                                                        'likes.$splittedEmail':
                                                            0,
                                                        'likesCount': snapshot1
                                                                .data!
                                                                .likesCount -
                                                            1
                                                      }),
                                                    }
                                                  else
                                                    {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Forum' +
                                                              widget.forumName)
                                                          .doc(post.referenceId)
                                                          .update({
                                                        'likes.$splittedEmail':
                                                            1,
                                                        'likesCount': snapshot1
                                                                .data!
                                                                .likesCount +
                                                            1
                                                      }),
                                                    }
                                                }
                                            },
                                          ),
                                          Text(
                                              snapshot1.data!.likesCount
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              )),
                                        ]),
                                        Text("       "),
                                        Row(children: [
                                          //height: 40.0,
                                          Icon(
                                            FontAwesomeIcons.comment,
                                            color: Colors.blueAccent,
                                            size: 17,
                                          ),

                                          Text(
                                              "     " +
                                                  snapshot.data!.length
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              )),
                                        ]),
                                      ]),
                                ]),
                          ),
                        ),
                      ),
                      // Row(children: [
                      //   Expanded(
                      //     child: SizedBox(
                      //       //height: 100.0,
                      //       child: ListTile(
                      //           leading: RichText(
                      //         text: TextSpan(children: [
                      //           WidgetSpan(
                      //             child: IconButton(
                      //               icon: Icon(
                      //                 FontAwesomeIcons.heart,
                      //                 color: Colors.red,
                      //                 size: 17,
                      //               ),
                      //               onPressed: () => {},
                      //             ),
                      //           ),
                      //           TextSpan(
                      //               text: "   " + widget.post.likes.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black45,
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 13,
                      //               )),
                      //         ]),
                      //       )),
                      //     ),
                      //   ),
                      //   SizedBox(
                      //     width: 0,
                      //   ),
                      //   Expanded(
                      //     child: SizedBox(
                      //       height: 40.0,
                      //       child: ListTile(
                      //           leading: RichText(
                      //         text: TextSpan(children: [
                      //           WidgetSpan(
                      //             child: Icon(
                      //               FontAwesomeIcons.comment,
                      //               color: Colors.blueAccent,
                      //               size: 17,
                      //             ),
                      //           ),
                      //           TextSpan(
                      //               text: "   " + snapshot.data!.length.toString(),
                      //               style: TextStyle(
                      //                 color: Colors.black45,
                      //                 fontWeight: FontWeight.w500,
                      //                 fontSize: 13,
                      //               )),
                      //         ]),
                      //       )),
                      //     ),
                      //   ),
                      // ]),
                      Container(
                        child: ListTile(
                            leading: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(
                                FontAwesomeIcons.comments,
                                color: Colors.blueAccent,
                              ),
                            ),
                            TextSpan(
                                text: '   Comments',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                )),
                          ]),
                        )),
                      ),
                      Expanded(
                          child: CommentList(
                        post: post,
                        commentController: commentController,
                        forumName: widget.forumName,
                      )),
                      Divider(),
                      ListTile(
                          title: TextFormField(
                            key: _formKey,
                            controller: commentController,
                            decoration: InputDecoration(
                                labelText: "Write a comment..."),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () async {
                              //if (_formKey.currentState?.validate() ?? false) {
                              Navigator.of(context);
                              final newComment = Comment(
                                userEmail: auth.currentUser!.email!,
                                body: commentController.text,
                                date: DateTime.now(),
                              );
                              post.comments!.add(newComment);
                              repository.updatePost(
                                  widget.post, widget.forumName);
                              commentController.clear();
                              // }
                              //widget.callback();
                            },
                          )

                          //   onPressed: () => print('add comment'),
                          //   //borderSide: BorderStyle.none,
                          //   //child:
                          // ),
                          ),
                    ],
                  );
                });
          }),
    );
  }
}
