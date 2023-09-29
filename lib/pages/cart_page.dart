import 'package:albums/models/albums_cart.dart';
import 'package:albums/pages/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cartItems = Provider.of<AlbumsCart>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const CatalogPage();
              }));
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Color.fromARGB(255, 29, 192, 224),
            )),
        title: const Text(
          "Cart",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 29, 192, 224),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 29, 192, 224),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView.builder(
              itemCount: cartItems.cartItems.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        child: Image.network(
                          cartItems.cartItems[index].albumCover,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            cartItems.cartItems[index].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '\$${cartItems.cartItems[index].price}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 228, 237, 245),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                cartItems.addQty(index);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Color.fromARGB(255, 29, 192, 224),
                              ),
                            ),
                            Text(
                              '${cartItems.cartItems[index].qty}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 29, 192, 224)),
                            ),
                            IconButton(
                              onPressed: () {
                                cartItems.removeQty(index);
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: Color.fromARGB(255, 29, 192, 224),
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            cartItems.removeItem(index);
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white,
                          ))
                    ],
                  ),
                );
              })),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "\$${cartItems.totalPrice}",
              style: const TextStyle(
                fontSize: 50,
                color: Color.fromARGB(255, 29, 192, 224),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Center(
                      child: Text("Buying not supported yet"),
                    ),
                  ),
                );
              },
              child: const Text(
                "BUY",
                style: TextStyle(
                  color: Color.fromARGB(255, 29, 192, 224),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
