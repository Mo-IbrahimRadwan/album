import 'package:albums/models/album.dart';
import 'package:albums/models/albums_catalog.dart';
import 'package:flutter/material.dart';

class AlbumsCart extends ChangeNotifier {
  final List<Album> _cartItems = [];
  List<Album> get cartItems => _cartItems;
  List<Album> catalogItems = AlbumsCatalog().catalogItems;
  int totalPrice = 0;
  int totalQty = 0;
  AlbumsCart();

  calQty() {
    totalQty = 0;
    for (var i = 0; i < _cartItems.length; i++) {
      totalQty = totalQty + _cartItems[i].qty;
    }
    notifyListeners();
  }

  calPrice() {
    totalPrice = 0;
    for (var i = 0; i < _cartItems.length; i++) {
      totalPrice = totalPrice + (_cartItems[i].price * _cartItems[i].qty);
    }
    notifyListeners();
  }

  addItem(int index) {
    if (!_cartItems.contains(catalogItems[index])) {
      _cartItems.add(catalogItems[index]);
    }
    calPrice();
    calQty();
    notifyListeners();
  }

  removeItem(int index) {
    _cartItems[index].qty = 1;
    _cartItems.remove(_cartItems[index]);
    calPrice();
    calQty();
    notifyListeners();
  }

  addQty(int index) {
    _cartItems[index].qty += 1;
    calPrice();
    calQty();
    notifyListeners();
  }

  removeQty(int index) {
    if (_cartItems[index].qty > 1) {
      _cartItems[index].qty -= 1;
    } else {
      removeItem(index);
    }
    calPrice();
    calQty();
    notifyListeners();
  }
}
