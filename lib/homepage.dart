import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articlesTendance = [];

  bool _isLoading = true;

  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _articlesTendance = await initListArticleTendance(_articlesTendance);

    setState(() {
      _isLoading = false;
      print('test');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? _loading() : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 15),
                child: Text(
                  'TENDANCES',
                  style: GoogleFonts.lilitaOne(
                    textStyle: const TextStyle(letterSpacing: .5, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _articlesTendance.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${_articlesTendance[index].getImages()[0]}',
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                  height:
                                      10), // Espacement entre l'image et les textes
                              Text(
                                '${_articlesTendance[index].designation}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${_articlesTendance[index].prix} €',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
              /*
                SizedBox(
                  height: 230,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _articlesTendance.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${_articlesTendance[index].getImages()[0]}',
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                  height:
                                      10), // Espacement entre l'image et les textes
                              Text(
                                '${_articlesTendance[index].designation}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${_articlesTendance[index].prix} €',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),*/
            ],
          ),
          Text('test')
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

  Widget _loading() {
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
                SizedBox(
                  height:
                      250, // Définissez une hauteur fixe pour votre ListView
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // Pour le test, utilisez un nombre fixe
                    itemBuilder: (context, index) {
                      return Container(
                        width:
                            180, // Assurez-vous de définir une largeur pour chaque élément dans une liste horizontale
                        margin: EdgeInsets.all(10),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 10,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: double.infinity,
                                          height: 10,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
