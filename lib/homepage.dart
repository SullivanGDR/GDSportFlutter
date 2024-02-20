import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articlesTendance = [];

  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _articlesTendance = await initListArticleTendance(_articlesTendance);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TENDANCES',
                  style: GoogleFonts.lilitaOne(
                    textStyle: const TextStyle(letterSpacing: .5, fontSize: 25),
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _articlesTendance.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Card(
                        child: Stack(
                          children: [
                            // Image en arrière-plan
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${_articlesTendance[index].getImages()[0]}'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            // Texte du nom de l'article
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  _articlesTendance[index].getDesignation(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
/*
          CarouselSlider.builder(
            itemCount: _articlesTendance.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${_articlesTendance[index].getImages()[0]}'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 175.0,
              aspectRatio: 16 / 9,
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
          ),*/
        ],
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
