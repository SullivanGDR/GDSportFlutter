import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CarouselSlider CarouselSliderPub(BuildContext context) {
  return CarouselSlider(
    items: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: const Center(
          child: Text(
            'SOLDES DERNIERES DEMARQUES',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: const Center(
          child: Text(
            'RESTOCK DES AF1',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: const Center(
          child: Text(
            'OFFRES ETUDIANTES',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    ],
    options: CarouselOptions(
      height: 50,
      autoPlay: true,
      viewportFraction: 1,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: true,
    ),
  );
}