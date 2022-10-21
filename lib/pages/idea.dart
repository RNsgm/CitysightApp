import 'package:flutter/material.dart';

class Idea extends StatefulWidget {
  const Idea({super.key});

  @override
  State<Idea> createState() => _IdeaState();
}

class _IdeaState extends State<Idea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Idea")),
    );
  }
}