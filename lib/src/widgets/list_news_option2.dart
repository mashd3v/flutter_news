import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/dark_theme.dart';

class ListNews2 extends StatelessWidget {
  final List<Article> news;
  const ListNews2(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _Notice(
          notice: this.news[index],
          index: index,
        );
      },
    );
  }
}

class _Notice extends StatelessWidget {
  final Article notice;
  final int index;
  const _Notice({
    @required this.notice,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 19.0,
        ),
        _TopBarCard(notice, index),
        _ImageCard(notice),
        SizedBox(
          height: 5.0,
        ),
        _TitleCard(notice),
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article notice;
  final int index;
  const _TopBarCard(this.notice, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 17.0,
      ),
      margin: EdgeInsets.only(
        bottom: 11.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17.0),
                color: darkTheme.accentColor),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            '${notice.source.name}',
            style: TextStyle(
              color: darkTheme.accentColor,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article notice;
  const _TitleCard(this.notice);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 17.0,
      ),
      margin: EdgeInsets.only(bottom: 17.0),
      child: Text(
        notice.title,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article notice;
  const _ImageCard(this.notice);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 17.0,
      ),
      child: (notice.urlToImage != null && notice.urlToImage.contains('http'))
          ? ClipRRect(
            borderRadius: BorderRadius.circular(17.0),
            child: FadeInImage(
                placeholder: AssetImage('assets/images/giphy.gif'),
                image: NetworkImage(notice.urlToImage),
              ),
          )
          : ClipRRect(
            borderRadius: BorderRadius.circular(17.0),
            child: Image(
                image: AssetImage('assets/images/no-image.png'),
              ),
          ),
    );
  }
}
