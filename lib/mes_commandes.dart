import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gdsport_flutter/details-commande.dart';
import 'package:gdsport_flutter/fonctions/commande_API.dart';
import 'package:intl/intl.dart';
import 'class/commande.dart';
import 'class/user.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class MesCommandePage extends StatefulWidget {
  const MesCommandePage() : super();

  @override
  State<MesCommandePage> createState() => _MesCommandePageState();
}

class _MesCommandePageState extends State<MesCommandePage> {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  User? user;
  List<Commande> listeCommandes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    var value = await storage.read(key: "userData");
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
    }
    listeCommandes = await getCommandesByIdUser(user!.getId(), listeCommandes);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Vos commandes',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: isLoading
            ? const CircularProgressIndicator()
            : ListView.builder(
          itemCount: listeCommandes.length,
          itemBuilder: (context, index) {
            Commande commande = listeCommandes[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.white,
              child: ListTile(
                title: Text(
                  "Commande #${commande.getId()}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Livraison prévue: ${DateFormat('dd/MM/yyyy').format(commande.getDateLivraison())}",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Text(
                      "Date de commande: ${DateFormat('dd/MM/yyyy').format(commande.getDateCommande())}",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsCommandePage(commande.getId()),
                    ),
                  );
                },
              ),
            );
          },
        ),

    );
  }
}
