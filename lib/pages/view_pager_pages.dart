import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:restourantapp/model/restaurant.dart';

class ViewPagerMenus extends StatelessWidget {
  final Restaurant restaurant;
  const ViewPagerMenus({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
              return MainColumn(restaurant: restaurant);
            } else {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.wifi_off,
                        size: 50,
                      ),
                      Text("your internet disconected"),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

class MainColumn extends StatelessWidget {
  const MainColumn({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orange.shade100, Colors.blue.shade100]),
              ),
              constraints: const BoxConstraints.expand(height: 70),
              child: const TabBarWidget(),
            ),
          ),
        ),
        Expanded(
          child: TabBarViewWidget(restaurant: restaurant),
        ),
      ],
    );
  }
}

class TabBarViewWidget extends StatelessWidget {
  const TabBarViewWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TabBarView(
        children: [
          MenuViewFood(
            foods: restaurant.menus.foods,
          ),
          MenuViewDrinks(
            drinks: restaurant.menus.drinks,
          ),
          MenuData(restaurant: restaurant)
        ],
      ),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(
          text: "Foods",
          icon: Icon(Icons.food_bank),
        ),
        Tab(
          text: "Drinks",
          icon: Icon(Icons.local_drink),
        ),
        Tab(
          text: "Profile",
          icon: Icon(Icons.account_circle_rounded),
        ),
      ],
      labelColor: Colors.black,
    );
  }
}

class MenuViewFood extends StatelessWidget {
  final List<Category> foods;
  const MenuViewFood({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: foods.length,
          itemBuilder: (context, index) {
            final Category food = foods[index];
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
  final List<Category> drinks;
  const MenuViewDrinks({Key? key, required this.drinks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: drinks.length,
          itemBuilder: (context, index) {
            final Category drink = drinks[index];
            return ListTile(
              leading: const Icon(Icons.local_drink),
              title: Text(drink.name),
              subtitle: const Text("Price not defined yet"),
            );
          }),
    );
  }
}

class MenuData extends StatelessWidget {
  final Restaurant restaurant;
  const MenuData({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              restaurant.name,
              style: Theme.of(context).textTheme.headline6,
            )),
      ),
      Row(
        children: [
          const Icon(Icons.place),
          Text(restaurant.city),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text("Description",
                style: Theme.of(context).textTheme.bodyText1)),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(restaurant.description),
        ),
      ),
    ]);
  }
}
