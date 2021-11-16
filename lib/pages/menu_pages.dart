import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourantapp/model/api/api_service.dart';
import 'package:restourantapp/model/restaurant.dart';
import 'package:restourantapp/pages/view_pager_pages.dart';
import 'package:restourantapp/viewmodel/provider/provider.dart';

class ViewDetailsMenu extends StatefulWidget {
  final String idRestaurant;
  static const routeNamed = "/restaurant_details";
  const ViewDetailsMenu({Key? key, required this.idRestaurant})
      : super(key: key);
  @override
  _ViewDetailsMenuState createState() => _ViewDetailsMenuState();
}

class _ViewDetailsMenuState extends State<ViewDetailsMenu> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(
          apiService: ApiService(), id: widget.idRestaurant),
      child: Scaffold(
        body: SafeArea(
          child:
              Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else if (state.state == ResultState.HasData) {
              return SliverBody(restaurant: state.result);
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.massage));
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.massage));
            } else {
              return const Text("");
            }
          }),
        ),
      ),
    );
  }
}

class SliverBody extends StatefulWidget {
  final Restaurant restaurant;
  const SliverBody({Key? key, required this.restaurant}) : super(key: key);

  @override
  _SliverBodyState createState() => _SliverBodyState();
}

class _SliverBodyState extends State<SliverBody> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: false,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Colors.green.shade100,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.restaurant.name),
                background: Image.network(
                  "https://restaurant-api.dicoding.dev/images/large/" +
                      widget.restaurant.pictureId,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("ERROR happens check your internet"),
                ),
              )),
        ];
      },
      body: ViewPagerMenus(restaurant: widget.restaurant),
    );
  }
}
