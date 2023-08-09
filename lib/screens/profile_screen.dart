import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_app_st26/services/firestore_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection('users');
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return Center(
      child: FutureBuilder<DocumentSnapshot>(
        future: db.doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data?.data() as Map<String, dynamic>;

              final name = data['username'];
              final photo = data['photo'];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // 1. select image - done
                      // 2. upload image - done
                      // 3. get link of image - done
                      // 4. save link to firestore
                      // 5. replace old photo with new photo
                      final ImagePicker picker = ImagePicker();

                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        final storageRef = FirebaseStorage.instance.ref();

                        final imageReference = storageRef.child(
                            'assets/profile_picture/${DateTime.now().millisecondsSinceEpoch}');

                        File file = File(image.path);

                        try {
                          await imageReference.putFile(file);

                          final imageUrl =
                              await imageReference.getDownloadURL();

                          final userId = FirebaseAuth.instance.currentUser?.uid;
                          FirestoreCollections.usersCollection
                              .doc(userId)
                              .set({
                            'photo': imageUrl,
                          }, SetOptions(merge: true));
                        } on FirebaseException catch (error) {
                          print('error : $error');
                        }
                      }
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(photo),
                    ),
                  ),
                  Text(name.toString()),
                  TextButton(
                    onPressed: () {
                      // context.read<PostCubit>().addPost(controller.text);

                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text('Logout!'),
                  ),
                ],
              );
            }
          }

          return const SizedBox();
        },
      ),
    );
  }
}
