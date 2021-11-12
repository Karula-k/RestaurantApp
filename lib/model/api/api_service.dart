import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restourantapp/model/restaurant.dart';

class ApiService {
  static const _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final _queryparam = {'q': 'es'};
  static const _apiSearch = "/search";
  static const _apiList = "/list";
  static const _apiDetail = "/detail/";
  Future<HeaderSearch> restaurantSearch() async {
    String uri = Uri(queryParameters: _queryparam).query;
    print(uri);
    var endpoint = _baseUrl + _apiSearch + "?" + uri;
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return HeaderSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to fetch api");
    }
  }

  Future<Header> restaurantlist() async {
    var endpoint = _baseUrl + _apiList;
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return Header.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to fetch api");
    }
  }

  Future<HeaderDetail> restaurantDetail(String id) async {
    var endpoint = _baseUrl + _apiDetail + id;
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return HeaderDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to fetch api");
    }
  }
}
