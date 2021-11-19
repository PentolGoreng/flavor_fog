//@dart=2.9

import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class News extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const News(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  static String routeName = "/news";
  final String title = 'Rss feed Demo';
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  //static const String FEED_URL = 'https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss';
  static const String FEED_URL = 'https://vapemagz.co.id/news/feed/';
  RssFeed _feed;
  String _title;
  static const String loadingFeedMsg = 'Loading feed....';
  static const String feedLoadErrorMsg = 'Error loading feed';
  static const String feedOpenErrorMsg = 'Error opening Feed';
  static const String placeholderImg = 'images/no_image.png';
  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch((url))) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response =
          await client.get(Uri.parse('https://vapemagz.co.id/news/feed/'));
      return RssFeed.parse(response.body);
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subtitle) {
    return Text(
      subtitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

//  image(){
//    if (null = item.enclosure.url) {
//
//    }
//  }

  list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        //return ListTile(
        return ListTile(
          title: title(item.title),
          //subtitle: subtitle(item.description),
          // subtitle: subtitle(item.description),

          leading: item.enclosure?.url != null
              ? thumbnail(item.enclosure.url)
              : SizedBox.shrink(), // Replace Container() with SizedBox.shrink()
          //leading: thumbnail(item.enclosure.url),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => openFeed(item.link),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: body(),
    );
  }
}
