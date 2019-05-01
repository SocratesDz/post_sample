import 'package:flutter/material.dart';
import 'package:posts_sample/api.dart';
import 'package:posts_sample/models.dart';
import 'package:posts_sample/screens/picture_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PicturesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Pictures"),
      ),
      body: FutureBuilder(
        future: Api.fetchPictures(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("No photos :("));
          } else if (snapshot.hasData) {
            final pictures = snapshot.data as List<Picture>;
            return GridView.count(
                crossAxisCount: 2,
                children: _generatePictureTiles(pictures));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<Widget> _generatePictureTiles(List<Picture> pictures) {
    return pictures.asMap().map((index, picture) =>
        MapEntry(index, GridTile(
    child: new InkWell(
      onTap: () => Navigator.push(context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) {
              return PictureSliderPage(pictures: pictures, indexPicture: index);
            },
            transitionsBuilder: (_, animation, __, child) {
              return new FadeTransition(opacity: animation, child: child);
            }
          ),
      ),
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
            heightFactor: 0.5,
            widthFactor: 0.5,
            child: CircularProgressIndicator()),
        imageUrl: picture.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    ),))).values.toList();
    }
}
