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

/*
CarouselSlider.builder(
            itemCount: _articlesTendance.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://s3-4674.nuage-peda.fr/GDSport/public/articles/${_articlesTendance[index].getImages()[0]}'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 175.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                // Callback when the page is changed
                print('Page changed to index $index, reason: $reason');
              },
              scrollDirection: Axis.horizontal,
            ),
          )
 */
