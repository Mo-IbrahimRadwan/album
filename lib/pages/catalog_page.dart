import 'package:albums/models/albums_cart.dart';
import 'package:albums/models/albums_catalog.dart';

import 'package:albums/pages/cart_page.dart';
import 'package:albums/pages/gallery.dart';
import 'package:albums/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:provider_shoper/data/change_cart.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    //Provider.of<NewAlbumCatalog>(context, listen: true).getCatalogItems();
    var catalogItems =
        Provider.of<AlbumsCatalog>(context, listen: true).catalogItems;
    var cartItems = Provider.of<AlbumsCart>(context, listen: true);

    return Scaffold(
      /************AppBar************ */
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoginPage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 29, 192, 224),
        title: const Text(
          " Albums Catalog",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              tooltip: 'Goto cart',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const CartPage();
                }));
              },
              icon: (cartItems.totalQty > 0)
                  ? const Icon(
                      Icons.shopping_cart,
                      color: Colors.purpleAccent,
                    )
                  : const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    )),
        ],
      ),
      /******************List**************** */
      body: (catalogItems.isEmpty)
          ? Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 50,
                height: 50,
                child: const CircularProgressIndicator(
                  color: Color.fromARGB(255, 29, 192, 224),
                ),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: catalogItems.length,
                    (context, index) {
                      //Provider.of<CatalogModel>(context, listen: false).getId(index);
                      return Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 29, 192, 224),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        margin:
                            const EdgeInsets.only(top: 5, left: 5, right: 5),
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return Gallery(id: index);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                  height: 80,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      catalogItems[index].albumCover,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                catalogItems[index].title,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 30,
                              child: Text(
                                '\$${catalogItems[index].price}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                cartItems.addItem(index);
                              },
                              child: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: (cartItems.cartItems.any((element) =>
                                          element.id == catalogItems[index].id))
                                      ? const Icon(
                                          Icons.check,
                                          color:
                                              Color.fromARGB(255, 29, 192, 224),
                                        )
                                      : const Text(
                                          "ADD",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 29, 192, 224),
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ),
                            )
                          ],
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
