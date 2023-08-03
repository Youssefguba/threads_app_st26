import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(photo),
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
