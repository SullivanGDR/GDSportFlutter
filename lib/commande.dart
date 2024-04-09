import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdsport_flutter/fonctions/commande_API.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'class/ajoutPanier.dart';
import 'class/user.dart';
import 'fonctions/panier_api.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class CommandePage extends StatefulWidget {
  const CommandePage() : super();

  @override
  State<CommandePage> createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  List<AjoutPanier> panier = [];
  User? user;
  int _currentPageIndex = 0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();
  final TextEditingController _paysController = TextEditingController();
  final TextEditingController _codePostalController = TextEditingController();
  final TextEditingController _cardNomController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  String? typeLivraison;
  int totalArticle = 0;
  double fraisDePort = 0;
  DateTime estimatedDeliveryDate = DateTime.now();
  double totalCommande = 0;
  var commandeId;

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    var value = await storage.read(key: "userData");
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
      panier = await getPanier(user?.getToken(), user?.getId(), panier);
    }
  }

  Future<void> commander() async {
    totalCommande = 0;
    totalCommande = fraisDePort + totalArticle;
    commandeId = await createCommande(user!.getId().toString(), DateTime.now(),
        typeLivraison!, estimatedDeliveryDate, totalCommande);
    for (var ajout in panier) {
      await createAjoutCommande(
          commandeId.toString(),
          ajout.getArticle().getId().toString(),
          ajout.getQte(),
          ajout.getArticle().getPrix(),
          ajout.getTaille());
      await delArticleP(user!.getToken(), ajout.getId());
    }
    print(commandeId);
    Navigator.popAndPushNamed(context, "/accueil");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('GDSport',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPageContent(_currentPageIndex),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: _currentPageIndex == 0
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              children: [
                _currentPageIndex != 0
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentPageIndex -= 1;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text('Précédent'),
                      )
                    : const SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.isEmpty ||
                        _nomController.text.isEmpty ||
                        _prenomController.text.isEmpty ||
                        _adresseController.text.isEmpty ||
                        _villeController.text.isEmpty ||
                        _paysController.text.isEmpty ||
                        _codePostalController.text.isEmpty ||
                        typeLivraison!.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Champs manquants'),
                            content: const Text('Veuillez remplir tous les champs.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      setState(() {
                        if (_currentPageIndex < 2) {
                          _currentPageIndex += 1;
                        } else {
                          commander();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Paiement effectué'),
                                content: const Text(
                                    'Votre paiement a été effectué avec succès.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(_currentPageIndex < 2 ? 'Suivant' : 'Payer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return _buildPage1();
      case 1:
        return _buildPage2();
      case 2:
        return _buildPage3();
      default:
        return _buildPage1();
    }
  }

  Widget _buildPage1() {
    return Column(
      children: <Widget>[
        const Center(
          child: Text(
            'Informations de livraison',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 15),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Email'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween,
          children: [
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: _nomController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nom'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _prenomController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Prenom'),
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 15),
          child: TextField(
            controller: _adresseController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Adresse (*)'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween,
          children: [
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: _villeController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Ville (*)'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _paysController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Pays (*)'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _codePostalController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'CP (*)'),
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 10),
          child: Text(
            'Délai de livraison',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile<String>(
              title: const Text('Livraison Standard'),
              value: 'standard',
              groupValue: typeLivraison,
              onChanged: (value) {
                setState(() {
                  typeLivraison = value;
                });
              },
              secondary: const Text(
                'Gratuit',
                style: TextStyle(fontSize: 17),
              ),
            ),
            RadioListTile<String>(
              title: const Text('Livraison Express'),
              value: 'express',
              groupValue: typeLivraison,
              onChanged: (value) {
                setState(() {
                  typeLivraison = value;
                });
              },
              secondary: const Text(
                '9.95€',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPage2() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Text(
            'Informations de paiement',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _cardNomController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nom sur la carte',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Numéro de carte',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.credit_card),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // ou MainAxisAlignment.spaceEvenly
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _expiryDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              labelText: 'MM/YY',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'CVV',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildPage3() {
    if (typeLivraison == "standard") {
      fraisDePort = 0;
    } else {
      fraisDePort = 9.95;
    }
    Column affichagePanier = Column(
      children: <Widget>[],
    );
    for (var ajout in panier) {
      totalArticle =
          totalArticle + (ajout.getArticle().getPrix() * ajout.getQte());
      affichagePanier.children.add(
        Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Image.network(
                'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${ajout.getArticle().getImages()[0]["name"]}',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ajout.getArticle().getDesignation(),
                    style: const TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Taille : ${ajout.getTaille()}"),
                  Text("Quantité : ${ajout.getQte()}"),
                  Text('${ajout.getArticle().getPrix()} €'),
                ],
              ),
            ),
          ],
        ),
      );
      affichagePanier.children.add(const SizedBox(height: 8));
    }
    if (typeLivraison == "standard") {
      estimatedDeliveryDate = DateTime.now().add(const Duration(days: 6));
    } else {
      estimatedDeliveryDate = DateTime.now().add(const Duration(days: 2));
    }
    return Column(
      children: [
        const Text(
          'Récapitulatif de la commande :',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        const Text(
          'Date de livraison estimée:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          DateFormat('dd/MM/yyyy').format(estimatedDeliveryDate),
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          'Livraison $typeLivraison',
          style: const TextStyle(fontSize: 18),
        ),
        const Divider(),
        const Text(
          'Adresse de livraison :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '${_nomController.text} ${_prenomController.text}',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          _adresseController.text,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          '${_codePostalController.text}, ${_villeController.text}',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          _paysController.text,
          style: const TextStyle(fontSize: 18),
        ),
        const Divider(),
        const Text(
          'Informations de paiement :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          _cardNomController.text,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          'XXXX.XXXX.XXXX.${_cardNumberController.text.substring(12, 16)}',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          '${_expiryDateController.text}, ${_cvvController.text}',
          style: const TextStyle(fontSize: 18),
        ),
        const Divider(),
        const Text(
          'Articles commandés :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        affichagePanier,
        const Divider(),
        Text(
          'Total article(s): $totalArticle €',
          style: const TextStyle(fontSize: 15),
        ),
        const Text(
          'Réduction(s) : 0.0 €',
          style: TextStyle(fontSize: 15),
        ),
        Text(
          'Frais de port : $fraisDePort €',
          style: const TextStyle(fontSize: 15),
        ),
        const Divider(),
        Text(
          'Total de la commande : ${fraisDePort + totalArticle} €',
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
