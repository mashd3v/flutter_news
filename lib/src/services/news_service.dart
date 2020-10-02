import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/country_model.dart';
// import 'package:news_app/src/models/country_model2.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _urlNews = 'https://newsapi.org/v2';
final _apiKey = '242da86cc92a45beba79fd707c8cee13';

class NewsService with ChangeNotifier {
  String _selectedCountry = 'mx';
  String _selectedCategory = 'business';

  List<Country> countries = [
    Country(Flag('MX', fit: BoxFit.cover), 'mx'),
    Country(Flag('US', fit: BoxFit.cover), 'us'),
    Country(Flag('RU', fit: BoxFit.cover), 'ru'),
    Country(Flag('NZ', fit: BoxFit.cover), 'nz'),
    Country(Flag('JP', fit: BoxFit.cover), 'jp'),
  ];

  List<String> get countryNames {
    List<String> names = [];
    countries.map((value) {
      names.add(value.name);
    }).toList();
    return names;
  }

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.baseballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> countryArticles = {};
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    countries.forEach((item) {
      this.countryArticles[item.name] = new List();
    });
    this.getArticlesByCountry(this._selectedCountry);

    categories.forEach((element) {
      this.categoryArticles[element.name] = new List();
    });
    this.getArticlesByCategory(this._selectedCategory);
  }

  get selectedCountry => this._selectedCountry;
  set selectedCountry(String value) {
    this._selectedCountry = value;
    this.getArticlesByCountry(value);
    notifyListeners();
  }

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String value) {
    this._selectedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticlesBySelectedCountry =>
      this.countryArticles[this.selectedCountry];
  List<Article> get getArticlesBySelectedCategory =>
      this.categoryArticles[this.selectedCategory];

  getArticlesByCountry(String country) async {
    if (this.countryArticles[country].length > 0) {
      categoryArticles[_selectedCategory].length = 0;
      getArticlesByCategory(_selectedCategory);
      return countryArticles[country];
    }
    final url = '$_urlNews/top-headlines?apiKey=$_apiKey&country=$country';
    final response = await http.get(url);
    final newsResponse = newsResponseFromJson(response.body);

    this.countryArticles[country].addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      // countryArticles[_selectedCountry].length = 0;
      // getArticlesByCountry(_selectedCountry);
      return categoryArticles[category];
    }
    final url =
        '$_urlNews/top-headlines?apiKey=$_apiKey&country=$selectedCountry&category=$category';
    final response = await http.get(url);
    final newsResponse = newsResponseFromJson(response.body);

    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}
