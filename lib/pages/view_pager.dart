import 'package:flutter/material.dart';
import 'package:restourantapp/model/restaurant.dart';

class ViewPagerMenus extends StatelessWidget {
  final Menu menu;
  const ViewPagerMenus({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.orange.shade100, Colors.blue.shade100]),
                ),
                constraints: const BoxConstraints.expand(height: 70),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: "Foods",
                      icon: Icon(Icons.food_bank),
                    ),
                    Tab(
                      text: "Drinks",
                      icon: Icon(Icons.local_drink),
                    ),
                  ],
                  labelColor: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MenuViewFood(
                    foods: menu.foods,
                  ),
                  MenuViewDrinks(
                    drinks: menu.drinks,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuViewFood extends StatelessWidget {
  final List<Food> foods;
  const MenuViewFood({required this.foods});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: foods.length,
          itemBuilder: (context, index) {
            final Food food = foods[index];
            return ListTile(
              leading: const Icon(Icons.food_bank),
              title: Text(food.name),
              subtitle: const Text("Price not defined yet"),
            );
          }),
    );
  }
}

class MenuViewDrinks extends StatelessWidget {
  final List<Drink> drinks;
  const MenuViewDrinks({required this.drinks});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: drinks.length,
          itemBuilder: (context, index) {
            final Drink drink = drinks[index];
            return ListTile(
              leading: const Icon(Icons.local_drink),
              title: Text(drink.name),
              subtitle: const Text("Price not defined yet"),
            );
          }),
    );
  }
}
