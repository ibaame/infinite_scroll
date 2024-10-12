// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/bloc/posts_bloc.dart';
import 'package:infinite_scroll/widgets/post_list_item.dart';
import 'package:infinite_scroll/widgets/loading_widget.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<PostsBloc>().add(GetPostsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts API"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return LoadingWidget();
            case PostStatus.success:
              if (state.posts.isEmpty) {
                return const Center(child: Text('No Posts'));
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.posts.length
                      ? LoadingWidget()
                      : PostListItem(post: state.posts[index]);
                },
              );
            case PostStatus.error:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.errorMessage),
                    TextButton(
                      onPressed: () {
                        context.read<PostsBloc>().add(GetPostsEvent());
                      },
                      child: Text('refresh'),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
