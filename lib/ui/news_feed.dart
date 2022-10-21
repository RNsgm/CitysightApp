import 'package:citysight_app/ui/newspaper_cards.dart';
import 'package:flutter/material.dart';

class NewsFeed extends StatefulWidget {
  NewsFeed({super.key, required this.ids});

  List<int> ids = [];
  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 636,
        child: ListView.separated(
          separatorBuilder:(context, index) => const SizedBox(width: 8,),
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 8),
          scrollDirection: Axis.horizontal,
          itemCount: widget.ids.length,
          itemBuilder: (context, count) {
            return NewspaperCardBig(id: widget.ids.elementAt(count));
          }
        ),
      ),
    );
  }
}