import 'dart:convert';
import 'package:logger/logger.dart';

class ItemType {
  String? name;
  String? label;

  ItemType(dynamic data) {
    name = data['name'];
    label = data['label'];
  }

}




