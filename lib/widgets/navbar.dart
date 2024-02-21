import 'package:flutter/material.dart';

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    title: const Text('GDSport',
        style: TextStyle(fontWeight: FontWeight.bold)),
    actions: const <Widget>[
      Padding(
          padding: EdgeInsets.only(right: 15), child: Icon(Icons.search)),
    ],
  );
}