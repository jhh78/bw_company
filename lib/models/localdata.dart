import 'package:hive/hive.dart';

part 'localdata.g.dart';

@HiveType(typeId: 0)
class Localdata {
  @HiveField(0)
  String uuid = '';

  @HiveField(1)
  String name = '';

  @HiveField(2)
  List<String> thumbUp;
  @HiveField(3)
  List<String> thumbDown;

  Localdata({
    required this.uuid,
    required this.name,
  })  : thumbUp = [],
        thumbDown = [];
}
