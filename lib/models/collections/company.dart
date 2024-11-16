import 'package:pocketbase/pocketbase.dart';

class Company {
  String id;
  String name;
  String? homepage;
  String? location;
  int thumbUp;
  int thumbDown;
  String? tags;
  bool isBlocked;
  Map<String, dynamic> extendsData;

  Company({
    this.id = '',
    this.name = '',
    this.homepage,
    this.location,
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
      homepage: record.data['homepage'],
      location: record.data['location'],
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
      homepage: json['homepage'],
      location: json['location'],
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
      'name': name,
      'homepage': homepage,
      'location': location,
      'thumbUp': thumbUp,
      'thumbDown': thumbDown,
      'tags': tags,
      'isBlocked': isBlocked,
      'extendsData': extendsData,
    };
  }
}
