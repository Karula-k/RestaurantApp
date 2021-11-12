import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restourantapp/model/restaurant.dart';
import 'package:restourantapp/pages/view_pages_menu.dart';

class ListRestaurant extends StatelessWidget {
  const ListRestaurant({Key? key}) : super(key: key);
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Restaurant",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Center(
                      child: Text(
                        "The best place we offer to you",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FutureBuilder<String>(
                builder: (context, snapshot) {
                  final List<Restaurant> restaurant =
                      parseRestaurant(snapshot.data);
                  return ListView.builder(
                      itemCount: restaurant.length,
                      itemBuilder: (context, index) {
                        return BuildRestaurant(restaurant: restaurant[index]);
                      });
                },
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_restaurant.json'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }
  final List parsed = jsonDecode(json)["restaurants"];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

class BuildRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  BuildRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.pushNamed(context, ViewDetailsMenu.routeNamed,
              arguments: restaurant);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Hero(
          tag: "dash${restaurant.id}",
          child: Image.network(
            restaurant.pictureId,
            width: 100,
            height: 120,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) =>
                const Text("ERROR happens \n check your internet"),
          ),
        ),
        title: Text(restaurant.name),
        subtitle: Column(children: [
          Row(
            children: [
              const Icon(Icons.place),
              Text(restaurant.city),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.star),
              Text(restaurant.rating.toString()),
            ],
          ),
        ]));
  }
}
