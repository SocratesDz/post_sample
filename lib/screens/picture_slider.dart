import 'package:flutter/material.dart';
import 'package:posts_sample/models.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PictureSliderPage extends StatefulWidget {
  final List<Picture> pictures;
  final int indexPicture;

  PictureSliderPage({List<Picture> pictures, int indexPicture}) :
        pictures = pictures, indexPicture = indexPicture;

  @override
  State createState() => _PictureSliderPageState();
}

class _PictureSliderPageState extends State<PictureSliderPage> {

  PageController controller;


  @override
  void initState() {
    super.initState();
    final int index = this.widget.indexPicture;
    controller = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: PageView.builder(
        controller: controller,
        itemCount: this.widget.pictures.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            placeholder: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
            imageUrl: this.widget.pictures[index].url,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}