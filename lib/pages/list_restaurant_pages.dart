import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourantapp/model/api/api_service.dart';
import 'package:restourantapp/model/restaurant.dart';
import 'package:restourantapp/pages/menu_pages.dart';
import 'package:restourantapp/viewmodel/provider/provider.dart';

class ListRestaurant extends StatelessWidget {
  const ListRestaurant({Key? key}) : super(key: key);
  static const routeName = '/restaurant_list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ListRestaurantProvider>(
              create: (_) => ListRestaurantProvider(apiService: ApiService()),
            ),
          ],
          builder: (context, child) => Column(
            children: [
              const Expanded(
                flex: 1,
                child: HeadBar(),
              ),
              StreamBuilder(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (BuildContext context,
                      AsyncSnapshot<ConnectivityResult> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data != ConnectivityResult.none) {
                      return const BodyList();
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class BodyList extends StatelessWidget {
  const BodyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Consumer<ListRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else if (state.state == ResultState.HasData) {
            if (state.result.isEmpty) {
              return const Center(
                child: Text("No data was found"),
              );
            } else {
              return ListView.builder(
                  itemCount: state.result.length,
                  itemBuilder: (context, index) {
                    return BuildRestaurant(restaurant: state.result[index]);
                  });
            }
          } else if (state.state == ResultState.Error) {
            return Center(child: Text(state.massage));
          } else if (state.state == ResultState.NoData) {
            return Center(child: Text(state.massage));
          } else {
            return const Text("Something wrong");
          }
        },
      ),
    );
  }
}

class HeadBar extends StatelessWidget {
  const HeadBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SafeArea(child: SearchBar()),
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
    );
  }
}

class BuildRestaurant extends StatelessWidget {
  final RestaurantListTile restaurant;
  const BuildRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.pushNamed(context, ViewDetailsMenu.routeNamed,
              arguments: restaurant.id);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Image.network(
          "https://restaurant-api.dicoding.dev/images/small/" +
              restaurant.pictureId,
          width: 100,
          height: 120,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) =>
              const Text("ERROR happens \n check your internet"),
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

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 230,
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (text) {
          if (text != "") {
            Provider.of<ListRestaurantProvider>(context, listen: false)
                .update(text);
          }
        },
        controller: _controller,
        decoration: InputDecoration(
            prefixIcon: IconButton(
                onPressed: _controller.clear, icon: const Icon(Icons.clear)),
            focusColor: Colors.green.shade700,
            hoverColor: Colors.green.shade100,
            suffixIcon: InkWell(
                onTap: () {
                  if (_controller.text != "") {
                    Provider.of<ListRestaurantProvider>(context, listen: false)
                        .update(_controller.text);
                  }
                },
                child: const Icon(Icons.search)),
            hintText: "Search restaurant"),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
