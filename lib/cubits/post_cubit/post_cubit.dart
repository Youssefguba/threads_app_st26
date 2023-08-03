import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:threads_app_st26/services/firestore_services.dart';

import '../../main.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final BuildContext context;

  PostCubit(this.context) : super(PostInitial());

  final postController = TextEditingController();

  // on Tap Post
  // 1. Check the post is empty! ( DONE )
  // 2. Check minimum length greater 4 ( DONE )
  // 3. Upload post to Firestore |
  //                             |-- Success --> Back && Message (Your post posted successfully) ( DONE )
  //                             |-- Failed --> Message (There is an error try again!) ( DONE )

  void onPostButtonPressed() {
    final isPostValidated = validateThePost();

    if (isPostValidated) {
      uploadPostToFirestore();
      navigatorKey.currentState!.pop();
    }
  }

  bool validateThePost() {
    if (postController.text.isEmpty) {
      globalMessenger.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Your Post is Empty!'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (postController.text.length < 4) {
      globalMessenger.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Your Post is smaller than 4 character!'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  void uploadPostToFirestore() async {
    try {
      final postCollection = FirestoreCollections.postsCollection;
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
      final name = FirebaseAuth.instance.currentUser?.displayName;

      await postCollection.add({
        'id': userId.toString(),
        'photo': photoUrl,
        'name': name,
        'content': postController.text,
        'timestamp': DateTime.now().toString(),
      });

      postController.clear();

      globalMessenger.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Your Post added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } on Exception catch (e) {
      globalMessenger.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            'There is an error try again! : ${e.toString()}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void getAllPosts() async {
    emit(LoadingPosts());
    final snapshot = await FirestoreCollections.postsCollection.get();
    emit(GetAllPostsSuccessfully(snapshot.docs));
  }
}
