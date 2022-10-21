import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citysight_app/cache/cached_content.dart';
import 'package:citysight_app/network/content.dart';
import 'package:citysight_app/network/network.dart';
import 'package:citysight_app/ui/default_dialog.dart';
import 'package:citysight_app/utils/system_prefs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loadany/loadany_widget.dart';
import 'package:skeleton_text/skeleton_text.dart';

class MainCard extends StatefulWidget {
  MainCard({super.key, required this.id});
  int id;
  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {

  bool isFavorite = false;
  Content content = Content();
  Map<String, dynamic> data = {};

  final SystemPrefs _prefs = SystemPrefs();

  String type = "";
  int likeCount = 0;

  Widget title = SkeletonAnimation(
    shimmerColor: Colors.white54,
    gradientColor: const Color.fromARGB(0, 244, 244, 244),
    curve: Curves.fastOutSlowIn,
    shimmerDuration: 1200,
    child: Container(color: Colors.grey.shade300, height: 30,)
  );
  Widget imageBlock = SkeletonAnimation(
    shimmerColor: Colors.white54,
    gradientColor: const Color.fromARGB(0, 244, 244, 244),
    curve: Curves.fastOutSlowIn,
    shimmerDuration: 1200,
    child: Container(color: Colors.grey.shade300, constraints: BoxConstraints(minHeight: 15))
  );
  Widget date = SkeletonAnimation(
    shimmerColor: Colors.white54,
    gradientColor: const Color.fromARGB(0, 244, 244, 244),
    curve: Curves.fastOutSlowIn,
    shimmerDuration: 1200,
    child: Container(color: Colors.grey.shade300, height: 10,)
  );
  Widget tags = SkeletonAnimation(
    shimmerColor: Colors.white54,
    gradientColor: const Color.fromARGB(0, 244, 244, 244),
    curve: Curves.fastOutSlowIn,
    shimmerDuration: 1200,
    child: Container(color: Colors.grey.shade300, height: 15,)
  );

  void cache() async{
    final cached = await Hive.openBox<CacheContent>("content");
    cached.put("Content${widget.id}", CacheContent(id: widget.id, data: data));
  }

  Future<void> _load() async {

    final cached = await Hive.openBox<CacheContent>("content");

    CacheContent? cachedContent = cached.get("Content${widget.id}");

    if(cachedContent != null){
      data = cachedContent.data;
    }

    if(data.isEmpty){
      int id = widget.id;
      if(id == 0) return;
      data = await content.getContentById(id);
      data.addAll(await content.isFavorited(id));
      cache();
    }

    setState((){
      isFavorite = data["favorited"];
      likeCount = data["likes"];

      imageBlock = Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "${Network.defaultUrl}/img/${data["markerImage"]}", 
            width: 320, 
            height: 320,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 6, bottom: 7.5),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: GestureDetector(
                        onTap: () async {
                          print("Old: ${data["favorited"]}");
                          if(await _prefs.getAuthToken() == ""){
                            NeedAuth(context).start();
                          }
                          IsLikedMeta state = await content.setFavoritedState(widget.id);
                          setState(() {
                            data["favorited"] = state.isLiked;
                            data["likes"] = state.count;
                            cache();
                            print("New: ${data["favorited"]}");
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: isFavorite ? 32 : 25,
                          height: isFavorite ? 32 : 25,
                          curve: Curves.bounceOut,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border, 
                              color: isFavorite ? Theme.of(context).colorScheme.secondary : Colors.white,
                            ),
                          )
                        ),
                      ),
                    )
                  ),
                  Text("$likeCount", style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
            ),
          ),
        ],
      );
      title = AutoSizeText(
        data["title"], 
        style: Theme.of(context).textTheme.titleLarge, 
        maxLines: 2,
        minFontSize: 14,
      );
      date = FittedBox(
        fit: BoxFit.fitWidth, 
        child: Text("10 июля • 2021", style: Theme.of(context).textTheme.labelSmall,),
      );
      tags = AutoSizeText(
        "#достопримечательности, #музеи, #маршрут, #замоскворечье, #достопримечательности, #музеи, #маршрут, #замоскворечье", 
        style: Theme.of(context).textTheme.bodyMedium, 
        maxLines: 2, 
        minFontSize: 10,
        overflow: TextOverflow.ellipsis,
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _load();
    return Card(
      elevation: 2,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: GestureDetector(
          onTap: (() => print("Tapped")),
          child: SizedBox(
            width: 320,
            height: 420,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 320,
                        height: 320,
                        child: imageBlock,
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 4, left: 16, right: 16),
                          child: title
                        )
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 2, left: 16, right: 16),
                          child: date
                        )
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 2, left: 16, right: 16),
                          child: tags
                        )
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 200,
                      height: 32,
                      margin: const EdgeInsets.only(top: 8),
                      color: Theme.of(context).colorScheme.secondary,
                      alignment: Alignment.center,
                      child: Text(type),
                    ),
                  ),
                ],
              )
            ),
          ),
        )
      )
    );
  }

}