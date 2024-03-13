import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

Drawer appDrawer(BuildContext context, bool isLog, String nomUtilisateur) {
  return Drawer(
    child: Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'GDSport',
                    style: GoogleFonts.zcoolKuaiLe(
                      textStyle: const TextStyle(
                          color: Colors.black, letterSpacing: .5, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Bienvenue',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Colors.black,
                      size: 36,
                    ),
                    SizedBox(width: 8),
                    Text(
                      isLog ? nomUtilisateur : 'utilisateur',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Text(
              'NAVIGATION',
              style: GoogleFonts.lilitaOne(
                textStyle: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Accueil'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.checkroom_outlined),
            title: const Text("Catalogue"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border_outlined),
            title: const Text('Favoris'),
            onTap: () {},
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 50), child: Divider()),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Text(
              'MON COMPTE',
              style: GoogleFonts.lilitaOne(
                textStyle: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          Visibility(
            visible: isLog,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text("Mes informations"),
                  onTap: () {
                    if (isLog == false) {
                      Navigator.popAndPushNamed(context, '/connexion');
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping_outlined),
                  title: const Text('Mes commandes'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Déconnexion'),
                  onTap: () async {
                    await storage.delete(key: "userData");
                    Navigator.popAndPushNamed(context, "/accueil");
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isLog,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.login_outlined),
                  title: const Text('Connexion'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/connexion");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_add_outlined),
                  title: const Text('Inscription'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/register");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
