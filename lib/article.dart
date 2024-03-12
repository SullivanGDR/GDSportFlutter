import 'package:flutter/material.dart';
import 'package:gdsport_flutter/widgets/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  String selectedSize = 'S'; // Taille par défaut
  bool _isDescriptionVisible = false;

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
            const Padding(padding: EdgeInsets.only(top: 50)),
            const Center(
              child: Text(
                'Nom de l article',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Divider(), // Divider au-dessus de la sélection des tailles
                  Row(
                    children: [
                      Text(
                        'Sélectionner la taille : ',
                        style: TextStyle(fontSize: 22.5),
                      ),
                      SizedBox(width: 10),
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
                  Divider(), // Divider au-dessus du bouton "Acheter"
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ExpansionPanelList(
                      elevation: 0,
                      expandedHeaderPadding: EdgeInsets.zero,
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text('Description'),
                              trailing: Icon(Icons.keyboard_arrow_down),
                              onTap: () {
                                setState(() {
                                  _isDescriptionVisible =
                                      !_isDescriptionVisible;
                                });
                              },
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _isDescriptionVisible
                                ? Text(
                                    'Lorsque Bilbon Sacquet hérite d\'un anneau mystérieux, il est loin de se douter de sa vraie valeur et de l\'aventure qu\'il va vivre. Cet anneau est en fait l\'un des Anneaux de Pouvoir, autrefois créés par Sauron, le Seigneur des Ténèbres. Il découvre alors que cet anneau lui confère un pouvoir immense qui le rend très convoité. Ainsi, il quitte la Comté pour se lancer dans une quête périlleuse pour détruire l\'anneau et vaincre Sauron. Accompagné d\'une communauté hétéroclite, comprenant des Hobbits, des Hommes, des Elfes et des Nains, Bilbon affronte de nombreux dangers et doit surmonter de terribles épreuves dans sa lutte pour sauver la Terre du Milieu.',
                                    style: TextStyle(fontSize: 16),
                                  )
                                : SizedBox.shrink(),
                          ),
                          isExpanded: _isDescriptionVisible,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 305,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Acheter',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text('Créer un compte ?'),
                    Text('ou'),
                    Text('mot de passe oublié')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
