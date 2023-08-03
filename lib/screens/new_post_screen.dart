import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/post_cubit/post_cubit.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text('Post'),
            onPressed: () {
              context.read<PostCubit>().onPostButtonPressed();
              // on Tap Post
              // 1. Check the post is empty!
              // 2. Check minimum length greater 4
              // 3. Upload post to Firestore |
              //                             |-- Success --> Back && Message (Your post posted successfully)
              //                             |-- Failed --> Message (There is an error try again!)


            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            maxLines: 20,
            controller: context.read<PostCubit>().postController,
            decoration: const InputDecoration(
              hintText: 'Write your post',
              contentPadding: EdgeInsets.all(8),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
