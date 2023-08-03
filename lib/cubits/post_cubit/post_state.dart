part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class GetAllPostsSuccessfully extends PostState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> posts;

  GetAllPostsSuccessfully(this.posts);
}

class LoadingPosts extends PostState {}