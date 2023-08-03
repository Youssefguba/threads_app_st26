import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app_st26/cubits/post_cubit/post_cubit.dart';
import 'package:threads_app_st26/services/firestore_services.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is LoadingPosts) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetAllPostsSuccessfully) {
          final posts = state.posts;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final singlePost = posts[index].data();

              return ListTile(
                title: Text(singlePost['name']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(singlePost['photo']),
                ),
                subtitle: Text(singlePost['content']),
                trailing: Text('33m'),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
