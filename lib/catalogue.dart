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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // appBar method implementation
      ),
      drawer: Drawer(
        // appDrawer method implementation
      ),
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
                    'Nouveautés',
                    style: GoogleFonts.lilitaOne(
                      textStyle: const TextStyle(letterSpacing: .5, fontSize: 23),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                  child: SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Nombre d'éléments à afficher
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  color: Colors.grey[300],
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Image Placeholder',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Nom de l\'article',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(
                                  'Prix',
                                  style: TextStyle(
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
                          style: TextStyle(color: Colors.black), // Couleur du texte
                        ),
                        icon: const Icon(Icons.arrow_forward, color: Colors.black), // Couleur de l'icône
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Couleur de fond
                          side: const BorderSide(color: Colors.black), // Couleur du contour
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
                        shape: const RoundedRectangleBorder(),
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
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
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
                        shape: const RoundedRectangleBorder(),
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
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
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
                        shape: const RoundedRectangleBorder(),
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
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
                                  child: Text(
                                    'Vestes et manteaux',
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
                        shape: const RoundedRectangleBorder(),
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
                                child: const Center(
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(10),
                                child: const Center(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}