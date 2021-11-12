import 'package:flutter/cupertino.dart';
import 'package:restourantapp/model/api/api_service.dart';
import 'package:restourantapp/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    _fetchList();
  }

  late List<RestaurantListTile> _restaurant;
  late ResultState _state;
  String _massage = "";

  List<RestaurantListTile> get result => _restaurant;
  ResultState get state => _state;
  String get massage => _massage;

  Future<dynamic> _fetchList() async {
    try {
      _state = ResultState.NoData;
      notifyListeners();
      final restaurant = await apiService.restaurantlist();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _massage = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = restaurant.restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _massage = 'Error--->$e';
    }
  }
}
