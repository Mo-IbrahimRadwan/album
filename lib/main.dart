import 'package:albums/models/albums_cart.dart';
import 'package:albums/models/albums_catalog.dart';
import 'package:albums/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AlbumsCatalog()),
        ChangeNotifierProvider(create: (context) => AlbumsCart()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Albums',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 29, 192, 224)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
