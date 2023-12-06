import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: const Icon(Icons.menu),
        actions: const <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15), child: Icon(Icons.search)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // CAROUSEL D'INFORMATIONS
            CarouselSlider(
              items: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black87,
                  child: const Center(
                    child: Text(
                      'SOLDES DERNIERES DEMARQUES',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black87,
                  child: const Center(
                    child: Text(
                      'RESTOCK DES AF1',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black87,
                  child: const Center(
                    child: Text(
                      'OFFRES ETUDIANTES',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 50,
                autoPlay: true,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Panier',
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}
