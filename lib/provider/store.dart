import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_task/model/store_info.dart';
import 'package:http/http.dart' as http;

class StoreProvider with ChangeNotifier {
  static const String url = 'https://bs.zoopt.org/api/v4.1/stocks';
  List<StoreInfo> list = [];
  List<StoreInfo> filtredList = [];
  String message = '';

  Future<void> getStoreInfo() async {
    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      fromJson(json.decode(response.body));
      message = '';
    } else {
      message = 'Ошибка запроса';
    }
    notifyListeners();
  }

  void fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      list.clear();
      json['data'].forEach((v) {
        list.add(StoreInfo.fromJson(v));
      });
      filtredList = list;
    }
  }

  void searchStore(String s) {
    if (s.isNotEmpty) {
      filtredList = list
          .where((element) =>
              element.title.toLowerCase().contains(s.toLowerCase()))
          .toList();
    } else {
      filtredList = list;
    }
    notifyListeners();
  }
}
