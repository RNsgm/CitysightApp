import 'package:citysight_app/ui/main_card.dart';
import 'package:flutter/material.dart';

class HomeFeed extends StatefulWidget {
  HomeFeed({super.key, required this.ids});

  List<int> ids = [];
  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 432,
        child: ListView.separated(
          separatorBuilder:(context, index) => const SizedBox(width: 8,),
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 8),
          scrollDirection: Axis.horizontal,
          itemCount: widget.ids.length,
          itemBuilder: (context, count) {
            print("Ids: ${widget.ids.elementAt(count)}");
            return MainCard(id: widget.ids.elementAt(count));
          }
        ),
      ),
    );
  }
}