part of 'posts_cubit.dart';

enum PostStatus {
  loading,
  success,
  error,
}

class PostsState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final String errorMessage;

  const PostsState({
    this.status = PostStatus.loading,
    this.posts = const [],
    this.hasReachedMax = false,
    this.errorMessage = "",
  });

  // to add new posts to old
  PostsState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    // "??" mean if parameter is null then take previous value
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax, errorMessage];
}
