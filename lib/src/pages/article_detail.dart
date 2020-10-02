import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/dark_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetail extends StatelessWidget {
  final newsService = new NewsService();

  @override
  Widget build(BuildContext context) {
    final Article article = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              _backgroundImage(article),
              _articleTitle(article),
              _noticeSourceName(article),
              _backButton(context),
            ],
          ),
          Divider(),
          SizedBox(
            height: 11.0,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.red[700],
                child: SingleChildScrollView(
                  child: Container(
                    color: darkTheme.scaffoldBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _articleTitle(article),
                        _articleContent(context, article),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backgroundImage(Article article) {
    return Hero(
      tag: article,
      child: Container(
        height: 250.0,
        width: double.infinity,
        child: (article.urlToImage != null && article.urlToImage.contains('http'))
            ? Image(
              image: NetworkImage(article.urlToImage),
              fit: BoxFit.cover,
            )
            : Image(
              image: AssetImage('assets/images/no-image.png'),
              fit: BoxFit.cover,
            ),
      ),
    );
  }

  Widget _articleTitle(Article article) {
    final date = article.publishedAt.toString();
    return Padding(
      padding: EdgeInsets.only(top: 250),
      child: Container(
        color: darkTheme.scaffoldBackgroundColor,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 17.0,
          vertical: 11.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${date.substring(0, 10)} • ',
                      style: TextStyle(color: Colors.white60),
                    ),
                    (article.author != null)
                        ? Text(
                            'by ${article.author}',
                            style: TextStyle(color: Colors.white60),
                          )
                        : Text(
                            'by ${article.source.name}',
                            style: TextStyle(color: Colors.white60),
                          ),
                  ],
                ),
                Icon(
                  FontAwesomeIcons.newspaper,
                  size: 14.0,
                  color: Colors.white60,
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            (article.title != null)
                ? Text(
                    article.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }

  Widget _articleContent(BuildContext context, Article article) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.0),
      child: (article.description != null && article.content != null)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _abstractArticle(article),
                _contentArticle(article),
              ],
            )
          : (article.description != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _contentArticle(article),
                  ],
                )
              : Center(
                  child: Text('Something went wrong loading this article'),
                ),
    );
  }

  Widget _abstractArticle(Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Abstract',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 7.0,
        ),
        Text(
          article.description,
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 23.0,
        ),
      ],
    );
  }

  Widget _contentArticle(Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 7.0,
        ),
        Text(
          article.content,
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 23.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'To see original article click ',
            ),
            GestureDetector(
              onTap: () async {
                if (await canLaunch(article.url)) {
                  await launch(article.url);
                } else {
                  throw 'Could not launch ${article.url}';
                }
              },
              child: Text(
                'here',
                maxLines: 1,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _noticeSourceName(Article article) {
    return Container(
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.fromLTRB(15.0, 210.0, 0.0, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.black54,
      ),
      child: (article.source.name != null)
          ? Text(
              '${article.source.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
            )
          : Text(''),
    );
  }

  Widget _backButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 40.0,
      ),
      child: Container(
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: darkTheme.scaffoldBackgroundColor,
          // color: Colors.red[500],
        ),
        child: GestureDetector(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 35.0,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
