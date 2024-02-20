import 'package:flutter/material.dart';
import 'package:gdsport_flutter/homepage.dart';

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    title: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      },
      child:
          const Text('GDSport', style: TextStyle(fontWeight: FontWeight.bold)),
    ),
    leading: const Icon(Icons.menu),
    actions: const <Widget>[
      Padding(padding: EdgeInsets.only(right: 15), child: Icon(Icons.search)),
    ],
  );
}
