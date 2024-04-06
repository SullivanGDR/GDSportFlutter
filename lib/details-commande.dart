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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (detailsCommande == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Récapitulatif de la commande'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Récapitulatif de la commande'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Column(
              children: [
                Text(
                  'Commande numéro : #${detailsCommande!.id}',
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
                Column(
                  children: detailsCommande!.ajoutCommande.map((ajout) {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${ajout.article.getImages()[0]}',
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ajout.article.getDesignation(),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      ],
                    );
                  }).toList(),
                ),
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
                  detailsCommande!.livraison == 'express' ? 'Frais de port : 9.95 €' : 'Frais de port : Gratuit',
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
        )
      );
    }
  }
}

