import 'package:flutter/material.dart';

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
            onPressed: () {},
            child: ListTile(
              title: Text(
                'Log in with Google',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
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
}
