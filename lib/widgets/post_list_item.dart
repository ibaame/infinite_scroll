// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                spreadRadius: 0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post.id.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
            title: Text(post.title),
            isThreeLine: true,
            subtitle: Text(post.body),
          ),
        ),
      ),
    );
  }
}
