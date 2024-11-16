import 'dart:developer';

import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';

const String location = "lib/services/user.dart";

Future<void> createUser() async {
  try {
    final uuid = const Uuid().v4().replaceAll('-', '');
    final pb = PocketBase(API_URL);
    final body = <String, dynamic>{"name": uuid};
    final record = await pb.collection('users').create(body: body);

    Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
    final localdata = Localdata(uuid: record.id, name: uuid);
    box.put(LOCAL_DATA, localdata);
  } catch (e) {
    writeLogs(location, e.toString());
    log("$e");
    rethrow;
  }
}

Future<void> blockContents(String blockId) async {
  try {
    Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
    Localdata? userData = box.get(LOCAL_DATA);

    if (userData == null) {
      throw Exception('User data is null');
    }

    userData.commentBlock.add(blockId.toString());
    box.put(LOCAL_DATA, userData);
  } catch (e) {
    writeLogs(location, e.toString());
    log("$e");
    rethrow;
  }
}
