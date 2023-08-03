import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static final _firebase = FirebaseFirestore.instance;

  static final usersCollection = _firebase.collection('users');
  static final postsCollection = _firebase.collection('posts');

}