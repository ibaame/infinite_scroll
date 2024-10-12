// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/bloc/posts_bloc.dart';
import 'package:infinite_scroll/screens/posts_screen.dart';
import 'helpers/my_bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc()..add(GetPostsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostsScreen(),
      ),
    );
  }
}
