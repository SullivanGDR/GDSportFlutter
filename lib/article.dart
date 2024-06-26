import 'package:flutter/material.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  String selectedSize = 'S';
  bool _isDescriptionVisible = false;
  bool _isAvisVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: CarouselSlider(
                options: CarouselOptions(),
                items: [
                  Text('Première image ou texte'),
                  Text('Deuxième image ou texte'),
                  Text('Troisième image ou texte'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Nom de l article',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Divider(), // Divider avant la sélection de la taille
                  Padding(padding: const EdgeInsets.only(top: 20)),
                  Row(
                    children: [
                      Text(
                        'Sélectionner la taille : ',
                        style: TextStyle(fontSize: 22.5),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: selectedSize,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSize = newValue!;
                          });
                        },
                        items: <String>[
                          'XS',
                          'S',
                          'M',
                          'L',
                          'XL',
                          'XXL',
                          'XXXL'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(), // Divider après la sélection de la taille
                  _buildExpansionPanel(
                    // Expansion Panel pour la description
                    title: 'Description',
                    content:
                        'Lorsque Bilbon Sacquet hérite d\'un anneau mystérieux, il est loin de se douter de sa vraie valeur et de l\'aventure qu\'il va vivre. Cet anneau est en fait l\'un des Anneaux de Pouvoir, autrefois créés par Sauron, le Seigneur des Ténèbres. Il découvre alors que cet anneau lui confère un pouvoir immense qui le rend très convoité. Ainsi, il quitte la Comté pour se lancer dans une quête périlleuse pour détruire l\'anneau et vaincre Sauron. Accompagné d\'une communauté hétéroclite, comprenant des Hobbits, des Hommes, des Elfes et des Nains, Bilbon affronte de nombreux dangers et doit surmonter de terribles épreuves dans sa lutte pour sauver la Terre du Milieu.',
                    isVisible: _isDescriptionVisible,
                    onPressed: () {
                      setState(() {
                        _isDescriptionVisible = !_isDescriptionVisible;
                      });
                    },
                  ),
                  const Divider(), // Divider après la description
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Acheter',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 35),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const [
                  Divider(), // Divider avant l'avis
                  SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text(
                  'Avis',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Michel C',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                          height: 5), // Ajoute un espace entre le nom et l'avis
                      Text(
                        '',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 1), // Ajout du Padding en dessous de l'avis
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionPanel({
    required String title,
    required String content,
    required bool isVisible,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 22.5),
                ),
                onTap: onPressed,
              );
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isVisible
                  ? Text(
                      content,
                      style: const TextStyle(fontSize: 16),
                    )
                  : const SizedBox.shrink(),
            ),
            isExpanded: isVisible,
          ),
        ],
      ),
    );
  }
}
