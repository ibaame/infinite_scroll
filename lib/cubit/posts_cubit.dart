// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/api/posts_api.dart';
import 'package:infinite_scroll/models/post.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(const PostsState());

  Future<void> GetPosts() async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.loading) {
        final posts = await PostsApi.getPosts();
        return posts.isEmpty
            ? emit(
                state.copyWith(status: PostStatus.success, hasReachedMax: true))
            : emit(state.copyWith(
                status: PostStatus.success,
                posts: posts,
                hasReachedMax: false,
              ));
      } else {
        final posts = await PostsApi.getPosts(state.posts.length);
        posts.isEmpty
            ? emit(state.copyWith(hasReachedMax: true))
            : emit(
                state.copyWith(
                    status: PostStatus.success,
                    posts: List.of(state.posts)..addAll(posts),
                    hasReachedMax: false),
              );
      }
    } catch (e) {
      emit(state.copyWith(
          status: PostStatus.error, errorMessage: "failed to fetch posts"));
    }
  }
}
