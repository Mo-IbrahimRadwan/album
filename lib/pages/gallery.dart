import 'package:albums/models/album.dart';
import 'package:albums/models/albums_cart.dart';
import 'package:albums/models/albums_catalog.dart';
import 'package:albums/pages/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Gallery extends StatelessWidget {
  int id;
  Gallery({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Album galleryItem = Provider.of<AlbumsCatalog>(context).catalogItems[id];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const CatalogPage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            )),
        title: Text(
          galleryItem.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Add to cart',
            onPressed: () {
              Provider.of<AlbumsCart>(context, listen: false).addItem(id);
            },
            icon: (Provider.of<AlbumsCart>(context, listen: true)
                    .cartItems
                    .any((element) => element.id == galleryItem.id))
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                  ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 29, 192, 224),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: galleryItem.images.length,
              (context, index) {
                return (galleryItem.images.isEmpty)
                    ? const CircularProgressIndicator()
                    : Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 5, right: 5),
                        width: double.maxFinite,
                        height: 300,
                        color: const Color.fromARGB(255, 29, 192, 224),
                        child: Image.network(
                          galleryItem.images[index],
                          fit: BoxFit.cover,
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
