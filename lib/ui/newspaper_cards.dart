import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citysight_app/network/content.dart';
import 'package:citysight_app/network/network.dart';
import 'package:citysight_app/ui/default_dialog.dart';
import 'package:citysight_app/utils/system_prefs.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class NewspaperCardBig extends StatefulWidget {
  NewspaperCardBig({super.key, required this.id});
  int id;
  @override
  State<NewspaperCardBig> createState() => _NewspaperCardBigState();
}

class _NewspaperCardBigState extends State<NewspaperCardBig> {

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

  Future<void> _load() async {

    if(data.isEmpty){
      int id = widget.id;
      if(id == 0) return;
      data = await content.getContentById(id);
      data.addAll(await content.isFavorited(id));
    }

    setState((){
      isFavorite = data["favorited"];
      likeCount = data["likes"];

      String image = data["markerImage"];
      data["markerImage"] = image.replaceAll(".s.", ".r.");
      imageBlock = Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "${Network.defaultUrl}/img/${data["markerImage"]}", 
            width: 200, 
            height: 348,
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
                          if(await _prefs.getAuthToken() == ""){
                            NeedAuth(context).start();
                          }
                          IsLikedMeta state = await content.setFavoritedState(widget.id);
                          setState(() {
                            data["favorited"] = state.isLiked;
                            data["likes"] = state.count;
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
    if(data.isEmpty){
      _load();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: GestureDetector(
          onTap: (() => print(data["markerImage"])),
          child: SizedBox(
            width: 200,
            height: 628,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 348,
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

  @override
  bool get wantKeepAlive => true;
}