
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping_cart_with_provider/db_helper.dart';

import 'cart_model.dart';

class CartProvider with ChangeNotifier{

  DbHelper db = DbHelper();

  int _counter = 0;
  int get counter => _counter ;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice  ;

  late Future<List<Cart>> _cart ;
  Future<List<Cart>> get cart => _cart ;

  Future<List<Cart>> getData () async {
    _cart = db.getCartList();
    return _cart ;
  }

  void _setPrefItems () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter) ;
    prefs.setDouble('total_price', _totalPrice) ;
    notifyListeners();
  }
  void _getPrefItems () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items')?? 0;
    _totalPrice = prefs.getDouble('total_price')?? 0.0;
    notifyListeners();
  }
  void addCounter () {
    _counter ++ ;
    _setPrefItems() ;
    notifyListeners();
  }
  void removeCounter () {
    _counter -- ;
    _setPrefItems() ;
    notifyListeners();
  }
  int getCounter () {
    _getPrefItems() ;
    return _counter ;
  }
  void addTotalPrice (double productPrice) {
    _totalPrice = _totalPrice + productPrice ;
    _setPrefItems() ;
    notifyListeners();
  }
  void removeTotalPrice (double productPrice) {
    _totalPrice = _totalPrice - productPrice ;
    _setPrefItems() ;
    notifyListeners();
  }
  double getTotalPrice () {
    _getPrefItems() ;
    return _totalPrice ;
  }
 }