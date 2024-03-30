import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/commande.dart';

class DetailsCommandePage extends StatefulWidget {
  final int commandeId;

  DetailsCommandePage(this.commandeId);

  @override
  State<DetailsCommandePage> createState() => _DetailsCommandePageState();
}

class _DetailsCommandePageState extends State<DetailsCommandePage> {
  var detailsCommande;

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    //detailsCommande = await getCommandesById(user!.getId(), listeCommandes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('GDSport',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.all(10), child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white70,
                      child: ListTile(
                        leading: const Icon(Icons.info_outline),
                        //title: Text('ID du bien : ${widget.bien.getBienId()}'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      color: Colors.white70,
                      child: ListTile(
                        leading: const Icon(Icons.person_2_outlined),
                        //title: Text('Propriétaire : ${widget.bien.getProprietaire()}'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      color: Colors.white70,
                      child: ListTile(
                        leading: const Icon(Icons.inventory_2_outlined),
                        //title: Text('Quantité : ${widget.bien.getQuantite()} (${widget.bien.getQuantitePrets()})'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      color: Colors.white70,
                      child: ListTile(
                        leading: const Icon(Icons.menu_book_outlined),
                        //title: Text('Type : ${widget.bien.getType()}'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      color: Colors.white70,
                      child: ListTile(
                        leading: const Icon(Icons.place),
                        //title: Text('Lieu : ${widget.bien.getEmplacement()}'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      color: Colors.white70,
                      child: ListTile(
                        leading: const Icon(Icons.message),
                        //title: Text('Commentaire : ${widget.bien.getCommentaire()}'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // Bouton Modifier
                        /*ElevatedButton.icon(
                          icon: const Icon(Icons.edit, color: Colors.white), // Icône pour Modifier
                          label: const Text('Modifier', style: TextStyle(color: Colors.white)),
                          /*onPressed: () {
                            Navigator.pushReplacement(
                              context,
                             // MaterialPageRoute(builder: (context) => UpdateInventairePage(inventaire: widget.bien)),
                            );
                          },*/
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white70)),
                        ),*/
                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete, color: Colors.white), // Icône pour Supprimer
                          label: const Text('Supprimer', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmation"),
                                  content: const Text("Êtes-vous sûr de vouloir supprimer cette réservation ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    /*TextButton(
                                      /*onPressed: () async {
                                       // await deleteInventaire(widget.bien.getId());
                                        Navigator.pushReplacement(
                                          context,
                                          //MaterialPageRoute(builder: (context) => const StocksPage()),
                                        );
                                      },*/
                                      child: const Text("Supprimer"),
                                    ),*/
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                        ),
                      ],
                    )
                  ],
                ),)
              ],
            ),
          ],
        )
    );
  }
}