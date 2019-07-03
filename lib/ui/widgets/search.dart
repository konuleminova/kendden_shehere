import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_list.dart';
import 'package:kendden_shehere/ui/page/test/old_test_cards.dart';

class SearchWidget extends SearchDelegate<String> {
  final vegetables = [
    "apple",
    "alfalfa sprout",
    "amaranth",
    "anise",
    "artichoke",
    "arugula",
    "asparagus",
    "aubergine",
    "azuki bean",
    "banana squash",
    "basil",
    "bean sprout",
    "beet",
    "black bean",
    "black-eyed pea",
    "bok choy",
    "borlotti bean",
    "broad beans",
    "broccoflower",
    "broccoli",
    "brussels sprout",
    "butternut squash",
    "cabbage",
    "calabrese",
    "caraway",
    "carrot",
    "cauliflower",
    "cayenne pepper",
    "celeriac",
    "celery",
    "chamomile",
    "chard",
    "chayote",
    "chickpea",
    "chives",
    "cilantro",
    "collard green",
    "corn",
    "corn salad",
    "courgette",
    "cucumber",
    "daikon",
    "delicata",
    "dill",
    "eggplant",
    "endive",
    "fennel",
    "fiddlehead",
    "frisee",
    "garlic",
    "gem squash",
    "ginger",
    "green bean",
    "green pepper",
    "habanero",
    "herbs and spice",
    "horseradish",
    "hubbard squash",
    "jalapeno",
    "jerusalem artichoke",
    "jicama",
    "kale",
    "kidney bean",
    "kohlrabi",
    "lavender",
    "leek ",
    "legume",
    "lemon grass",
    "lentils",
    "lettuce",
    "lima bean",
    "mamey",
    "mangetout",
    "marjoram",
    "mung bean",
    "mushrooms",
    "mustard green",
    "navy bean",
    "nettles",
    "new zealand spinach",
    "nopale",
    "okra",
    "onion",
    "oregano",
    "paprika",
    "parsley",
    "parsnip",
    "patty pan",
    "peas",
    "pinto bean",
    "potato",
    "pumpkin",
    "radicchio",
    "radish",
    "rhubarb",
    "rosemary",
    "runner bean",
    "rutabaga",
    "sage",
    "scallion",
    "shallot",
    "skirret",
    "snap pea",
    "soy bean",
    "spaghetti squash",
    "spinach",
    "squash ",
    "sweet potato",
    "tabasco pepper",
    "taro",
    "tat soi",
    "thyme",
    "tomato",
    "topinambur",
    "tubers",
    "turnip",
    "wasabi",
    "water chestnut",
    "watercress",
    "white radish",
    "yam",
    "zucchini"
  ];
  final recentVegetables = [
    "apple",
    "banana",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // print(products.productsInCategory);
    // TODO: implement buildResults
    return CardsPage();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggesstionList = query.isEmpty
        ? vegetables
        : vegetables.where((p) => p.startsWith(query)).toList();
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (context) => GroceryListPage("titile"));
            return Navigator.push(context, route);
          },
          title: new Text(suggesstionList[index]),
        );
      },
      itemCount: suggesstionList.length,
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: Colors.lightGreen,
        primaryIconTheme: theme.primaryIconTheme);
  }
}
