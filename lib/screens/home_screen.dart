import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threads_app_st26/screens/new_post_screen.dart';
import 'package:threads_app_st26/screens/profile_screen.dart';
import 'package:threads_app_st26/screens/time_line_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final _screens = const [
    TimelineScreen(),
    NewPostScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NewPostScreen(),
              ),
            );
            return;
          }
          setState(() => currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: ''),
        ],
      ),
      body: _screens[currentIndex],
    );
  }
}
