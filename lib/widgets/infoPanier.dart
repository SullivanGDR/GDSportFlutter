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
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      overflow: TextOverflow.visible,
                      ajout.getArticle().getDesignation(),
                      style: GoogleFonts.lilitaOne(
                        textStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
                  Text("Taille : ${ajout.getTaille()}"),
                  const Text('110 €'),
                  Row(
                    children: [
                      const Text("Quantité : "),
                      const Icon(Icons.remove_circle_outline),
                      Text("${ajout.getQte()}"),
                      const Icon(Icons.add_circle_outline)
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            const Icon(Icons.delete),
          ],
        ),
      ),
    );
    affichagePanier.children.add(const SizedBox(height: 8));
  }
  return affichagePanier;
}
