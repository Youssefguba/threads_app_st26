import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:threads_app_st26/cubits/post_cubit/post_cubit.dart';
import 'package:threads_app_st26/models/post_model.dart';
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
    initializeDateFormatting('ar');
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
              final rawData = posts[index].data();
              final singlePost = SinglePostModel.fromJson(rawData);
              final time = DateTime.tryParse(singlePost.timestamp ?? '1968-08-04');
              final dateFormat = DateFormat.yMEd('ar');
              final dateString = dateFormat.format(time!);

              // user.id
              // final userdata = FirestoreCollection.usersCollection.doc(user.id).get()
              // final image = userdata.data()['photo']
              return ListTile(
                title: Text(singlePost.username.toString()),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    singlePost.userPhoto ??
                        'https://static.vecteezy.com/system/resources/previews/001/840/618/original/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-free-vector.jpg',
                  ),
                ),
                subtitle: Text(singlePost.content ?? 'No content!'),
                trailing: Text(dateString.toString()),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
