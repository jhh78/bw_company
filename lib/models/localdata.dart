import 'package:hive/hive.dart';

part 'localdata.g.dart';

@HiveType(typeId: 0)
class Localdata {
  @HiveField(0, defaultValue: '')
  String uuid;

  @HiveField(1, defaultValue: '')
  String name;

  @HiveField(2, defaultValue: [])
  List<String> thumbUp;

  @HiveField(3, defaultValue: [])
  List<String> thumbDown;

  @HiveField(4, defaultValue: [])
  List<String> commentBlock;

  Localdata({
    required this.uuid,
    required this.name,
  })  : thumbUp = [],
        thumbDown = [],
        commentBlock = [];

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'thumbUp': thumbUp,
      'thumbDown': thumbDown,
      'commentBlock': commentBlock,
    };
  }
}
