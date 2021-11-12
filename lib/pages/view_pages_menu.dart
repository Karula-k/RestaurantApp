import 'package:flutter/material.dart';
import 'package:restourantapp/model/restaurant.dart';
import 'package:restourantapp/pages/view_pager.dart';

class ViewDetailsMenu extends StatefulWidget {
  final Restaurant restaurant;
  static const routeNamed = "/restaurant_details";
  const ViewDetailsMenu({required this.restaurant});
  @override
  _ViewDetailsMenuState createState() => _ViewDetailsMenuState();
}

class _ViewDetailsMenuState extends State<ViewDetailsMenu> {
  bool menu = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              child: Flexible(
                  child: MenuData(
                restaurant: widget.restaurant,
              )),
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              height: menu ? (size.height - 100) * 1 / 3 : size.height * 2 / 3,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      menu = !menu;
                    });
                  },
                  child: Expanded(
                      child: ViewPagerMenus(menu: widget.restaurant.menus))),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuData extends StatelessWidget {
  final Restaurant restaurant;
  MenuData({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: "dash${restaurant.id}",
            child: Image.network(
              restaurant.pictureId,
              errorBuilder: (context, error, stackTrace) =>
                  const Text("ERROR happens check your internet"),
            ),
          ),
        ),
      ),
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
      SizedBox(
        height: 100,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(restaurant.description),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Menus",
              style: Theme.of(context).textTheme.bodyText1,
            )),
      ),
    ]);
  }
}
