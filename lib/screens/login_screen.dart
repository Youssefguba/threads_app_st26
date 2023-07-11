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

  Future<UserCredential> signInWithGoogle() async {
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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
