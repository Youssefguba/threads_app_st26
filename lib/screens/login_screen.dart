import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Image.asset('assets/images/pattern.png'),
          OutlinedButton(
            onPressed: () async {
              final credential = await signInWithGoogle();
              // if (credential.user != null) {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (_) => const HomeScreen(),
              //     ),
              //   );
              // }
            },
            child: ListTile(
              title: const Text(
                'Log in with Google',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: const Text(
                'Youssefguba',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Image.asset('assets/images/logo_google.png'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );


    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    addDataToFirestore(googleUser);
  }

  void addDataToFirestore(GoogleSignInAccount? googleUser) {
    final name = googleUser?.displayName;
    final photo = googleUser?.photoUrl;

    final userId = FirebaseAuth.instance.currentUser?.uid;

    final usersCollection = FirebaseFirestore.instance.collection('users');

    usersCollection.doc(userId).set(
      {
        'username': name,
        'photo': photo,
      },
    );
  }
}

// New Post Screen --> Content --> Save/Upload Firestore
// Timeline --> Display/Get Content from Firestore