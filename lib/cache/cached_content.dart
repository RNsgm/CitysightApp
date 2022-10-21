
import 'package:hive/hive.dart';
part 'cached_content.g.dart';

@HiveType(typeId: 1)
class CacheContent extends HiveObject{
  CacheContent({required this.id, required this.data});

  @HiveField(0)
  int id;

  @HiveField(1)
  Map<String, dynamic> data;

  @override
  String toString() {
    return "Content with id = $id";
  }

}

