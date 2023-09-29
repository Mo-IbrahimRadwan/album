import 'dart:convert';

import 'package:albums/models/album.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumsCatalog extends ChangeNotifier {
  final List<Album> _catalogItems = [];
  List<Album> get catalogItems => _catalogItems;
  AlbumsCatalog() {
    fetchAlbum();
  }
  final String url =
      'https://my-json-server.typicode.com/Mo-IbrahimRadwan/album1/albums';
  Future fetchAlbum() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      for (Map<String, dynamic> d in data) {
        Album album = convertToAlbum(d);

        catalogItems.add(album);
      }
    } else {
      throw Exception(response.statusCode);
    }
    notifyListeners();
  }

  Album convertToAlbum(Map<String, dynamic> json) {
    return Album(
        id: json['id'],
        title: json['title'],
        qty: 1,
        price: json['price'],
        albumCover: json['albumCover'],
        images: json['images']);
  }
}
