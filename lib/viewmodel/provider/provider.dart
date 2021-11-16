import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:restourantapp/model/api/api_service.dart';
import 'package:restourantapp/model/restaurant.dart';

// ignore: constant_identifier_names
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
  void update(String query) {
    _fetchListUpdate(query);
  }

  Future<dynamic> _fetchList() async {
    try {
      _state = ResultState.Loading;
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

  Future<dynamic> _fetchListUpdate(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.restaurantSearch(query);
      if (restaurant.error) {
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

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;
  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchList();
  }
  late Restaurant _restaurant;
  late ResultState _state;
  String _massage = "";

  Restaurant get result => _restaurant;
  ResultState get state => _state;
  String get massage => _massage;

  Future<dynamic> _fetchList() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.restaurantDetail(id);
      if (restaurant.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _massage = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = restaurant.restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _massage = 'Error--->$e';
    }
  }
}
