import 'dart:developer';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

void writeLogs(String location, String text) {
  log("$location: $text");

  final pb = PocketBase(API_URL);
// example create data
  // example create body
  final body = <String, dynamic>{"log": text, "location": location};

  pb.collection('exceptions').create(body: body);
}
