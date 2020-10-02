import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/dark_theme.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;
  const ListNews(this.news);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return _Notice(
      news: this.news,
      screenSize: _screenSize,
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({
    Key key,
    @required this.news,
    @required Size screenSize,
  })  : _screenSize = screenSize,
        super(key: key);

  final Size _screenSize;
  final List<Article> news;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenSize.height * 0.7,
      width: _screenSize.width * 0.9,
      child: Swiper(
        loop: true,
        scrollDirection: Axis.vertical,
        duration: 100,
        scale: .4,
        itemHeight: _screenSize.height * 0.7,
        itemWidth: _screenSize.width * 0.8,
        itemCount: this.news.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
              'articleDetail',
              arguments: news[index],
            ),
            child: Stack(
              children: [
                _NoticeImage(
                  news: news,
                  index: index,
                  screenSize: _screenSize,
                ),
                _NoticeSourceName(
                  news: news,
                  index: index,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _NoticeTitle(
                      news: news,
                      index: index,
                    ),
                    _NoticeDescription(
                      news: news,
                      index: index,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NoticeDescription extends StatelessWidget {
  const _NoticeDescription({
    Key key,
    @required this.news,
    @required this.index,
  }) : super(key: key);

  final List<Article> news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // List: [Colors.black, Colors.transparent],
          colors: [Colors.black, Colors.transparent],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(17.0),
          bottomRight: Radius.circular(17.0),
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 11.0),
      child: (news[index].description != null)
          ? Text(
              news[index].description,
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            )
          : Text(''),
    );
  }
}

class _NoticeTitle extends StatelessWidget {
  const _NoticeTitle({
    Key key,
    @required this.news,
    @required this.index,
  }) : super(key: key);

  final List<Article> news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 17.0,
      ),
      margin: EdgeInsets.only(bottom: 17.0),
      child: (news[index].title != null)
          ? Text(
              news[index].title,
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                background: Paint()..color = darkTheme.accentColor,
              ),
            )
          : Text(''),
    );
  }
}

class _NoticeSourceName extends StatelessWidget {
  const _NoticeSourceName({
    Key key,
    @required this.news,
    @required this.index,
  }) : super(key: key);

  final List<Article> news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.black54,
      ),
      child: (news[index].source.name != null)
          ? Text(
              '${news[index].source.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
              ),
            )
          : Text(''),
    );
  }
}

class _NoticeImage extends StatelessWidget {
  const _NoticeImage({
    Key key,
    @required this.news,
    @required this.index,
    @required Size screenSize,
  })  : _screenSize = screenSize,
        super(key: key);

  final Size _screenSize;
  final List<Article> news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenSize.height * 0.7,
      width: _screenSize.width,
      child: Hero(
        tag: news[index],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17.0),
          child: (news[index].urlToImage != null &&
                  news[index].urlToImage.contains('http'))
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(17.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/giphy.gif'),
                    image: NetworkImage(news[index].urlToImage),
                    fit: BoxFit.cover,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(17.0),
                  child: Image(
                    image: AssetImage('assets/images/no-image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
