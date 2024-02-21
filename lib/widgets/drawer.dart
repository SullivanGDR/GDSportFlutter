import 'package:flutter/material.dart';

Drawer appDrawer(BuildContext context) {
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(
                  'GDSport',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
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
                      'utilisateur',
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
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
            child: const Text(
              '-- Catalogues --',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.man),
            title: const Text("Homme"),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.woman),
            title: const Text('Femme'),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.cruelty_free),
            title: const Text('Enfant'),
            onTap: () {

            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
            child: const Text(
              '-- Compte --',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profil"),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favoris'),
            onTap: () {

            },
          ),
        ],
      ),
    ),
  );
}
