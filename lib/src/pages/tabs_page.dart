import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/dark_theme.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final newsService = new NewsService();
  String currentValue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'NEWS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
              decoration: TextDecoration.none,
            ),
          ),
          actions: [
            _dropdownCreator(context),
            SizedBox(
              width: 11.0,
            ),
          ],
          backgroundColor: darkTheme.accentColor,
        ),
        body: Stack(
          children: [
            _Pages(),
          ],
        ),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }

  Widget _dropdownCreator(BuildContext context) {
    return DropdownButton<String>(
      underline: Container(),
      icon: Icon(FontAwesomeIcons.angleDown, color: Colors.white, size: 19.0,),
      value: currentValue,
      hint: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.only(right: 11.0),
            width: 25.0,
            height: 25.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Flag(
                'MX',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            'MX',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      dropdownColor: darkTheme.accentColor,
      items: newsService.countryNames
          .map<DropdownMenuItem<String>>((String countryName) {
        return DropdownMenuItem<String>(
          value: countryName,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(right: 11.0),
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Flag(
                    countryName.toUpperCase(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // SizedBox(
              //   width: 5.0,
              // ),
              Text(
                countryName.toUpperCase(),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          currentValue = value;
        });
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCountry = currentValue;
      },
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return CurvedNavigationBar(
      color: darkTheme.primaryColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      height: 55.0,
      index: navigationModel.currentPage,
      onTap: (i) => navigationModel.currentPage = i,
      items: [
        Icon(
          Icons.person_outline,
          size: 30.0,
          color: darkTheme.accentColor,
        ),
        Icon(
          Icons.public,
          size: 30.0,
          color: darkTheme.accentColor,
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = new PageController();

  // Getters
  int get currentPage => this._currentPage;
  PageController get pageController => this._pageController;

  // Setters
  set currentPage(int value) {
    this._currentPage = value;

    _pageController.animateToPage(
      value,
      duration: Duration(
        milliseconds: 250,
      ),
      curve: Curves.fastOutSlowIn,
    );

    notifyListeners();
  }
}
