import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/dark_theme.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: Center(
        child: _CategoryPage(newsService: newsService),
      ),
    );
  }
}

class _CategoryPage extends StatelessWidget {
  const _CategoryPage({
    @required this.newsService,
  });

  final NewsService newsService;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CategoryList(),
        SingleChildScrollView(
          child: ListNews(newsService.getArticlesBySelectedCategory),
        ),
      ],
    );
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 60.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          // final categoryName = categories[index].name;
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 13.0),
            child: _CategoryButton(
              category: categories[index],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;
  const _CategoryButton({this.category});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        padding: EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          shape: BoxShape.rectangle,
          color: (newsService.selectedCategory == this.category.name)
              ? darkTheme.accentColor
              : Colors.white70,
        ),
        child: Row(
          children: [
            Icon(
              category.icon,
              size: 16.0,
              color: (newsService.selectedCategory == this.category.name)
                  ? Colors.white70
                  : Colors.black54,
            ),
            SizedBox(
              width: 7.0,
            ),
            Text(
              category.name.toUpperCase(),
              style: TextStyle(
                fontWeight: (newsService.selectedCategory == this.category.name)
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: (newsService.selectedCategory == this.category.name)
                    ? Colors.white70
                    : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
