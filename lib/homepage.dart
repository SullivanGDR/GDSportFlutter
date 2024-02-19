import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = [];

  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _articles = await initListArticleTendance(_articles);
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
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
            ),
            CarouselSlider.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage('https://s3-4674.nuage-peda.fr/GDSport/public/articles/${_articles[index].getImages()[0]}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 175.0,
                aspectRatio: 16/9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  // Callback when the page is changed
                  print('Page changed to index $index, reason: $reason');
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
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
