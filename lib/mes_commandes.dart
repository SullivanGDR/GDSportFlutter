import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gdsport_flutter/details-commande.dart';
import 'package:gdsport_flutter/fonctions/commande_API.dart';
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
          title: const Text('GDSport',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: listeCommandes.length,
                itemBuilder: (context, index) {
                  Commande commande = listeCommandes[index];
                  return ListTile(
                    title: Text("Commande #${commande.getId()}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Livraison prévue: ${commande.getDateLivraison()}"),
                        Text("Date de commande: ${commande.getDateCommande()}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsCommandePage(commande.getId()),
                          ),
                        );
                      },
                    ),
                  );
                },
              ));
  }
}
