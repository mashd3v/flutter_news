import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    
    return Scaffold(
      body: Center(
        child: (newsService.getArticlesBySelectedCountry.length == 0)
            ? CircularProgressIndicator()
            : ListNews(newsService.getArticlesBySelectedCountry),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}