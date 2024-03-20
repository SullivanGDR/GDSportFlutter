import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/article.dart';
import 'package:gdsport_flutter/fonctions/article_API.dart';
import 'package:gdsport_flutter/widgets/drawer.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class Catalogue extends StatefulWidget {
  const Catalogue({super.key});

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
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
      drawer: appDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    'Tendances',
                    style: GoogleFonts.lilitaOne(
                      textStyle:
                          const TextStyle(letterSpacing: .5, fontSize: 23),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
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
                            margin: const EdgeInsets.symmetric(horizontal: 2),
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
                ),
// Bouton "Afficher tout" avec une flèche
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Espacement
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: const Text(
                          'Afficher tout',
                          style: TextStyle(
                              color: Colors.black), // Couleur du texte
                        ),
                        icon: Icon(Icons.arrow_forward,
                            color: Colors.black), // Couleur de l'icône
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Couleur de fond
                          side: BorderSide(
                              color: Colors.black), // Couleur du contour
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur l'encre
                    },
                    child: Center(
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: RoundedRectangleBorder(),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'Hauts',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur l'encre
                    },
                    child: Center(
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: RoundedRectangleBorder(),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'Bas',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur l'encre
                    },
                    child: Center(
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: RoundedRectangleBorder(),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'Vestes et manteux',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      // Action à effectuer lors du clic sur l'encre
                    },
                    child: Center(
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        shape: RoundedRectangleBorder(),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(),
                                ),
                                child: Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'Pyjamas et vêtements confort',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Column(
                    children: [
                      Text('© 2024 GDSport, Inc. Tous droits réservés.')
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
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
