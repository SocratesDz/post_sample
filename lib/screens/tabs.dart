import 'package:flutter/material.dart';
import 'package:posts_sample/screens/posts.dart';
import 'package:posts_sample/screens/pictures.dart';

class TabsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabsWidgetState();
  }
}

class TabsWidgetState extends State<TabsWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
          child: TabBar(
        labelColor: Colors.blue,
        controller: _controller,
        tabs: <Widget>[
          new Tab(icon: Icon(Icons.book)),
          new Tab(icon: Icon(Icons.photo))
        ],
      )),
      body: new TabBarView(
        controller: _controller,
        children: <Widget>[new PostsPage(), new PicturesPage()],
      ),
    );
  }
}
