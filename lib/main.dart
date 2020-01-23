import 'package:flutter/material.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static User _owner = User("null94", "https://i.imgur.com/CO6a0oX.jpg");
  static User _user = User("solo322", "https://steamcdn-a.akamaihd.net/apps/570/icons/econ/items/pudge/arcana/pudge_arcana_back_large.1d6857a5b278ba1a3e5381b76344fcf206052983.png");

  final List<Post> _items = <Post>[
    Post(_owner,["https://zdnet3.cbsistatic.com/hub/i/r/2018/08/19/f539d101-d210-4c94-ac50-bf7ed004865d/resize/1200x675/f5965c50ee88adfdbb3ef1cd9ef1cec6/dota-2.png", "https://digistatement.com/wp-content/uploads/2020/01/345f508f5b58522b2ca2b5c19253b005_720.jpg", "https://www.gosugamers.net/files/images/features/2015/august/dotapicks.jpg"], "Valve has released a small update to Dota 2 that aims to improve the game’s matchmaking experience by removing the variance in Matchmaking Rating (MMR) gained or lost for wins and losses in ranked matches.", Like(9999, [_user]), true, false),
    Post(_owner,["https://s.videogamer.com/meta/ff24/96260775-cd58-4949-b1f0-089861672a82_pangolier-pirate.jpg"], "Since the introduction of ranked matchmaking in Dota 2 back in December 2013, there has been a hidden MMR variance mechanic in place for players with high MMR that only gave marginal gains for wins but huge reductions for losses.", Like(322, [_user]), false, false),
    Post(_owner,["https://assets.vg247.com/current//2016/12/dota_2_7-0_the_new_journey_sun_wukong_monkey_king.jpg"], "For example, a player at around the 6,000 MMR range would, more often than not, gain 10 MMR for winning a ranked match but have 40 MMR shaved off after a loss. With the latest matchmaking update, winning a ranked match will now give players 30 MMR if they queued solo and 20 MMR if they queued with a party.", Like(13, [_user]), true, false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        backgroundColor: Color(0xfff8faf8),
        centerTitle: true,
        elevation: 1.0,
        leading: Icon(FontAwesomeIcons.camera),
        title: SizedBox(
            height: 40.0,
            child: Image.asset("assets/images/insta_logo.png")
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(FontAwesomeIcons.paperPlane),
          )
        ],
      ),
      body:  _buildList(),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.plusSquare),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: Text(""),
          ),
        ]),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return _buildItem(_items[index]);
        });
  }

  Widget _buildItem(Post item) {

    Widget _buildHeader(User user) {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            user.url
                        )
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  user.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            IconButton(
              iconSize: 16.0,
              icon: Icon(FontAwesomeIcons.ellipsisH),
              onPressed: () {

              },
            )
          ],
        ),
      );
    }

    Widget _buildContent(Post item) {

      PageController _controller = PageController(
        initialPage: 0,
      );

      Widget _buildPages(List<String> items) {

        Widget _buildPage(String url) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      url
                  )
              ),
            ),
          );
        }

        return Expanded(
          child: PageView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildPage(items[index]);
              }),
        );
      }

      Widget _buildActions(Post item) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                          item.isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                          color: item.isLiked ? Colors.red : null
                      ),
                      onPressed: () {
                        setState(() {
                          item.isLiked = !item.isLiked;
                          item.like.numberOfLikes = item.isLiked ? ++item.like.numberOfLikes : --item.like.numberOfLikes;
                        });
                      }
                  ),
                  IconButton(
                      icon: Icon(FontAwesomeIcons.comment),
                      onPressed: () {

                      }
                  ),
                  IconButton(
                      icon: Icon(FontAwesomeIcons.paperPlane),
                      onPressed: () {

                      }
                  )
                ],
              ),
              IconButton(
                  icon: Icon(
                      item.isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark
                  ),
                  onPressed: () {
                    setState(() {
                      item.isSaved = !item.isSaved;
                    });
                  }
              )
            ],
          ),
        );
      }

      return SizedBox(
        height: 300,
        child: Column(
          children: <Widget>[
            _buildPages(item.contents),
            Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  _buildActions(item),
                  ScrollingPageIndicator(
                    dotColor: Colors.grey,
                    dotSelectedColor: Colors.blue,
                    dotSize: 6,
                    dotSelectedSize: 6,
                    dotSpacing: 10,
                    controller: _controller,
                    itemCount: item.contents.length,
                    orientation: Axis.horizontal,
                  )
                ])
          ],
        ),
      );
    }

    Widget _buildFooter(Post item) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 16.0,
                  width: 16.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            item.like.users.first.url
                        )
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "Liked by ",
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: item.like.users.first.username, style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " and "),
                        TextSpan(text: item.like.numberOfLikes.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " others", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: item.owner.username,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: " ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                        TextSpan(text: item.comment, style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal))
                      ],
                    ),
                  ),
                ),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            item.owner.url
                        )
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add a comment...",
                    ),
                  ),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "2 hours ago",
                      style: TextStyle(color: Colors.grey, fontSize: 10.0)
                  )
                ]
            )
          ])
      );
    }

    return Column(
      children: <Widget>[
        _buildHeader(item.owner),
        _buildContent(item),
        _buildFooter(item)
      ]
    );


  }
}


class Post {
  Post(this.owner, this.contents, this.comment, this.like, this.isLiked, this.isSaved);

  User owner;
  List<String> contents;
  String comment;
  Like like;

  bool isLiked;
  bool isSaved;
}

class User {
  User(this.username, this.url);

  String username;
  String url;
}

class Like {
  Like(this.numberOfLikes, this.users);

  int numberOfLikes;
  List<User> users;
}