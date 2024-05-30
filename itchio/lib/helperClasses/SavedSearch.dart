import 'dart:convert';

import 'package:itchio/helperClasses/Game.dart';

class SavedSearch {
  String? type;
  String? filters;
  bool? notify;
  List<Game>? items;

  SavedSearch(Map<String, dynamic> data) {
    type = data['type'];
    filters = data['filters'];
    notify = data['notify'];
    items = (data['items'] as List<dynamic>?)
        ?.map((d) => Game(d as Map<String, dynamic>))
        .toList() ?? [];
  }

  SavedSearch.fromJson(String jsonUser) {
    var data = json.decode(jsonUser);
    type = data['type'];
    notify = data['notify'];
    filters = data['filters'];
    items = (data['items'] as List<dynamic>?)
        ?.map((d) => Game(d as Map<String, dynamic>))
        .toList() ?? [];
  }

  void setNotify(bool newValue) {
    notify = newValue;
  }
}



