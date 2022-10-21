import 'package:citysight_app/network/content.dart';
import 'package:citysight_app/ui/home_feed.dart';
import 'package:citysight_app/ui/news_feed.dart';
import 'package:citysight_app/ui/surface.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  Content content = new Content();
  Map<String, List<int>> feeds = {
    "main": [0,0,0,0,0],
    "news": [0,0,0,0,0],
    "places": [0,0,0,0,0],
    "events": [0,0,0,0,0]
  };

  Future<void> load() async {
    Map<String, dynamic> data = await content.feeds();
    feeds = data.map((key, value) => MapEntry(key, List<int>.from(value)));
    setState((){});
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: load,
      child: ListView(
        // reverse: true,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          // Surface(title: "Скидки и акции", onPressed: (() => print("Press")),)s
          Surface(title: "Главные события", onPressed: (() => print("Press")),),
          HomeFeed(ids: feeds['main']!),
          Surface(title: "Новости и факты", onPressed: (() => print("Press")),),
          NewsFeed(ids: feeds['news']!),
          Surface(title: "Предстоящие мероприятия", onPressed: (() => print("Press")),),
          Surface(title: "Новые места и маршруты", onPressed: (() => print("Press")),),
        ],
      )
      
    );
  }
}