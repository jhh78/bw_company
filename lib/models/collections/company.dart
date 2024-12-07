import 'package:pocketbase/pocketbase.dart';

class Company {
  String id;
  String refUser;
  String name;
  int thumbUp;
  int thumbDown;
  String? tags;
  bool isBlocked;
  Map<String, dynamic> extendsData;

  Company({
    this.id = '',
    this.refUser = '',
    this.name = '',
    this.thumbUp = 0,
    this.thumbDown = 0,
    this.tags = '',
    this.isBlocked = false,
    this.extendsData = const {},
  });

  factory Company.fromRecordModel(RecordModel record) {
    return Company(
      id: record.id,
      name: record.data['name'],
      thumbUp: record.data['thumbUp'] ?? 0,
      thumbDown: record.data['thumbDown'] ?? 0,
      tags: record.data['tags'],
      isBlocked: false,
      extendsData: record.expand,
    );
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      thumbUp: json['thumbUp'] ?? 0,
      thumbDown: json['thumbDown'] ?? 0,
      tags: json['tags'],
      isBlocked: json['isBlocked'] ?? false,
      extendsData: json['extendsData'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'refUser': refUser,
      'name': name,
      'thumbUp': thumbUp,
      'thumbDown': thumbDown,
      'tags': tags,
      'isBlocked': isBlocked,
      'extendsData': extendsData,
    };
  }
}
