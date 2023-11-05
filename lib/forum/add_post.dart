import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/models/post.dart';
import 'package:pet_health_app/repository/data_repository.dart';

class AddPost extends StatefulWidget {
  final String forumName;
  const AddPost({Key? key, required this.forumName}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  late String headline;
  late String body;
  late String userEmail;
  late DateTime date;
  late Post newPost;
  late final Map<String, int>? _likes;
  //late DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DataRepository repository = DataRepository();
  final FirebaseAuth auth = FirebaseAuth.instance;
  //String userEmail;

  @override
  Widget _buildHeadlineField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Headline'),
      maxLength: 50,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Headline is Required';
        }
      },
      onSaved: (String? value) {
        headline = value!;
      },
    );
  }

  Widget _buildBodyField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Body',
      ),
      minLines: 1,
      keyboardType: TextInputType.multiline,
      maxLength: 200,
      maxLines: 8,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Body is Required';
        }
      },
      onSaved: (String? value) {
        body = value!;
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeadlineField(),
              _buildBodyField(),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                  child: Text(
                    'Add Post',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () async => {
                        if (!_formKey.currentState!.validate())
                          {
                            //
                          }
                        else
                          {
                            _formKey.currentState!.save(),
                            userEmail = auth.currentUser!.email!,
                            if (headline != null && body != null)
                              {
                                newPost = Post(
                                  headline: headline,
                                  body: body,
                                  userEmail: userEmail,
                                  date: DateTime.now(),
                                  comments: [],
                                  //likes: _likes,
                                ),

                                // likes: _likes![auth.currentUser!.email]=0 as bool ),
                                repository.addPost(newPost, widget.forumName),
                                Navigator.of(context).pop()
                              }
                          }
                        // print(headline),
                        // print(body)
                      })
            ],
          ),
        ),
      ),
    );
  }
}
