import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:huz/View/wishlist/model/wishlist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListController with ChangeNotifier {
  static const _key = 'tasks';
  var isFav = false;


  void toggle(bool isFav){
    isFav =! isFav;
    notifyListeners();
  }



  Future<void> addTask(WishList wishList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> wishItems = prefs.getStringList(_key) ?? [];

    wishItems.add(json.encode(wishList.toJson()));

    await prefs.setStringList(_key, wishItems);
    notifyListeners();
  }

  Future<void> removeTask(WishList wishList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> wishItems = prefs.getStringList(_key) ?? [];

    wishItems.removeWhere((data) {
      final wishListDate = json.decode(data);
      return wishListDate['id'] == wishList.id;
    });

    await prefs.setStringList(_key, wishItems);
  }

  Future<List<WishList>> getTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasks = prefs.getStringList(_key) ?? [];

    return tasks.map((date) {
      final wishListDate = json.decode(date);
      return WishList(
        hotel2: wishListDate['hotel2'],
        packageImage: wishListDate['packageImage'],
          id: wishListDate['id'],
          packageName: wishListDate['packageName'],
          startDate: wishListDate['startDate'],
          endDate: wishListDate['endDate'],
          cost: wishListDate['cost'],
          incldues: wishListDate['include'],
          rating: wishListDate['rating']);
    }).toList();

  }

  List<WishList> list = [];

  notifyListeners();
}
