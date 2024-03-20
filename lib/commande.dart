import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum PaymentMethod {
  creditCard,
  paypal,
  // Ajoutez d'autres méthodes de paiement selon vos besoins
}

class Commande extends StatefulWidget {
  const Commande() : super();

  @override
  State<Commande> createState() => _CommandeState();
}

class _CommandeState extends State<Commande> {
  int _currentPageIndex = 0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();
  final TextEditingController _paysController = TextEditingController();
  final TextEditingController _codePostalController = TextEditingController();
  TextEditingController _cardNomController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  String? typeLivraison;

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
            SizedBox(height: 20),
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
                        child: Text('Précédent'),
                      )
                    : SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    // Vérifier si tous les champs sont remplis
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
                            title: Text('Champs manquants'),
                            content: Text('Veuillez remplir tous les champs.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Fermer la boîte de dialogue
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Tous les champs sont remplis, passer à la page suivante
                      setState(() {
                        _currentPageIndex += 1;
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
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Email'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // ou MainAxisAlignment.spaceEvenly
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
              .spaceBetween, // ou MainAxisAlignment.spaceEvenly
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
          //padding: EdgeInsets.symmetric(horizontal: 15),
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
          Text(
            'Informations de paiement',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
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
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                            decoration: InputDecoration(
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
                            decoration: InputDecoration(
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
    DateTime estimatedDeliveryDate = DateTime.now();
    if (typeLivraison == "standard") {
      estimatedDeliveryDate = DateTime.now().add(Duration(days: 6));
    } else {
      estimatedDeliveryDate = DateTime.now().add(Duration(days: 2));
    }
    return Column(
      children: [
        Text(
          'Récapitulatif de la commande :',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(),
        Text(
          'Date de livraison estimée:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '${DateFormat('dd/MM/yyyy').format(estimatedDeliveryDate)}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Livraison $typeLivraison',
          style: TextStyle(fontSize: 18),
        ),
        Divider(),
        Text(
          'Adresse de livraison :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '${_nomController.text} ${_prenomController.text}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          '${_adresseController.text}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          '${_codePostalController.text}, ${_villeController.text}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          '${_paysController.text}',
          style: TextStyle(fontSize: 18),
        ),
        Divider(),
        Text(
          'Informations de paiement :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '${_cardNomController.text}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'XXXX.XXXX.XXXX.${_cardNumberController.text.substring(12, 16)}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          '${_expiryDateController.text}, ${_cvvController.text}',
          style: TextStyle(fontSize: 18),
        ),
        Divider(),
        Text(
          'Articles commandés :',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
