import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomPhoto extends StatelessWidget {
  const ZoomPhoto({this.imageProvider});
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        heroAttributes: PhotoViewHeroAttributes(tag: "gambar"),
      ),
    );
  }
}
