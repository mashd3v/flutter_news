import 'package:flutter/material.dart';
import 'package:news_app/src/pages/article_detail.dart';
import 'package:news_app/src/pages/tabs_page.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/dark_theme.dart';
import 'package:provider/provider.dart';

void main(){runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        title: 'Material App',
        // home: TabsPage(),
        initialRoute: 'tabsPage',
        routes: {
          'tabsPage': (BuildContext context) => TabsPage(),
          'articleDetail': (BuildContext context) => ArticleDetail(),
        },
      ),
    );
  }
}
