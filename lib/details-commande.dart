import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/detailsCommande.dart';
import 'package:intl/intl.dart';

import 'fonctions/commande_API.dart';

class DetailsCommandePage extends StatefulWidget {
  final int commandeId;

  DetailsCommandePage(this.commandeId);

  @override
  State<DetailsCommandePage> createState() => _DetailsCommandePageState();
}

class _DetailsCommandePageState extends State<DetailsCommandePage> {
  DetailsCommande? detailsCommande;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    detailsCommande = await getCommandeById(widget.commandeId);
    setState(() {
      detailsCommande;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Column affichagePanier = Column(
      children: <Widget>[],
    );
    for (var ajout in detailsCommande!.ajoutCommande) {
      affichagePanier.children.add(
        Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Text('${ajout.article.getImages()[1]}'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ajout.article.getDesignation(),
                    style: TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Taille : ${ajout.taille}"),
                  Text("Quantité : ${ajout.quantite}"),
                  Text('${ajout.prixUnit} €'),
                ],
              ),
            ),
          ],
        ),
      );
      affichagePanier.children.add(const SizedBox(height: 8));
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('GDSport',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: isLoading
            ? CircularProgressIndicator()
            : ListView(
                children: [
                  Column(
                    children: [
                      Text(
                        'Récapitulatif de la commande :',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Text(
                        'Date de livraison estimée:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${DateFormat('dd/MM/yyyy').format(detailsCommande!.dateLivraison)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Livraison ${detailsCommande!.livraison}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(),
                      Text(
                        'Articles commandés :',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      affichagePanier,
                      Divider(),
                      Text(
                        'Total article(s): ${detailsCommande!.totalPrix} €',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Réduction(s) : 0.0 €',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Frais de port : a modif €',
                        style: TextStyle(fontSize: 15),
                      ),
                      Divider(),
                      Text(
                        'Total de la commande : ${detailsCommande!.totalPrix} €',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ));
  }
}
