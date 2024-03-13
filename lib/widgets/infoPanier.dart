import 'package:flutter/material.dart';
import 'package:gdsport_flutter/class/ajoutPanier.dart';
import 'package:google_fonts/google_fonts.dart';

Widget infoPanier(List<AjoutPanier> panier) {
  Column affichagePanier = Column(
    children: <Widget>[],
  );
  for (var ajout in panier) {
    affichagePanier.children.add(
      InkWell(
        onTap: () {},
        child: Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Image.network(
                'https://s3-4672.nuage-peda.fr/GDSport/public/articles/${ajout.getArticle().getImages()[0]["name"]}',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ajout.getArticle().getDesignation(),
                    style: GoogleFonts.lilitaOne(
                      textStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Taille : ${ajout.getTaille()}"),
                  Text('${ajout.getArticle().getPrix()} €'),
                  Row(
                    children: [
                      const Text("Quantité : "),
                      InkWell(
                        onTap: () {
                          print('moins');
                        },
                        child: Icon(Icons.remove_circle_outline),
                      ),
                      Text("${ajout.getQte()}"),
                      InkWell(
                        onTap: () {
                          print('plus');
                        },
                        child: Icon(Icons.add_circle_outline),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Icon(Icons.delete_outline),
          ],
        ),
      ),
    );
    affichagePanier.children.add(const SizedBox(height: 8));
  }
  return affichagePanier;
}
