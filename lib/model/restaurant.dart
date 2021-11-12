import 'dart:convert';

Header welcomeFromJson(String str) => Header.fromJson(json.decode(str));

String welcomeToJson(Header data) => json.encode(data.toJson());

class Header {
  Header({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<RestaurantListTile> restaurants;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantListTile>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class HeaderDetail {
  HeaderDetail({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  bool error;
  String message;
  List<RestaurantListTile> restaurants;

  factory HeaderDetail.fromJson(Map<String, dynamic> json) => HeaderDetail(
        error: json["error"],
        message: json["message"],
        restaurants: List<RestaurantListTile>.from(
            json["restaurants"].map((x) => RestaurantListTile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class HeaderSearch {
  HeaderSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantListTile> restaurants;

  factory HeaderSearch.fromJson(Map<String, dynamic> json) => HeaderSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantListTile>.from(
            json["restaurants"].map((x) => RestaurantListTile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantListTile {
  RestaurantListTile({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantListTile.fromJson(Map<String, dynamic> json) =>
      RestaurantListTile(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late Menu menus;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus});
  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    menus = Menu.fromJson(restaurant['menus']);
  }
}

class Menu {
  late List<Food> foods;
  late List<Drink> drinks;
  Menu({required this.foods, required this.drinks});
  Menu.fromJson(Map<String, dynamic> menu) {
    foods = List<Food>.from(menu["foods"].map((x) => Food.fromJson(x)));
    drinks = List<Drink>.from(menu["drinks"].map((x) => Drink.fromJson(x)));
  }
}

class Food {
  late String name;
  Food({required this.name});
  Food.fromJson(Map<String, dynamic> food) {
    name = food['name'];
  }
}

class Drink {
  late String name;
  Drink({required this.name});
  Drink.fromJson(Map<String, dynamic> drink) {
    name = drink['name'];
  }
}
