import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/widgets/carousels.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
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
            CarouselSliderPub(context),
            const Row(
              children: [
                Padding(padding: EdgeInsets.all(10),
                child: Text("Dernières tendances", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)))
              ],
            ),
            CarouselSlider.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage('https://s3-4674.nuage-peda.fr/GDSport/public/articles/${_articles[index].getImages()[0]}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 125.0,
                aspectRatio: 16/9,
                viewportFraction: 0.5,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 2400),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  print('Page changed to index $index, reason: $reason');
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(15),
                    child: Text("test"),)
              ],
            ),
            const Row(
              children: [
                Padding(padding: EdgeInsets.all(10),
                    child: Text("Catalogue", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)))
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Favoris',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        child: const Icon(CupertinoIcons.heart),
      ),
    );
  }
}
