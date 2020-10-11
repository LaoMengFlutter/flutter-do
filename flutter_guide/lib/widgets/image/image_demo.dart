import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

///
/// des:
///
class ImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
          width: double.infinity,
        ),
//        Image.network(
//          'http://pic1.win4000.com/pic/c/cf/cdc983699c.jpg',
//        ),
//        Image.asset('assets/images/aa.jpg',width: 100,height: 200,),
//        Image.file(File('path')),
//        Row(
//          children: <Widget>[
//            Container(
//              color: Colors.red.withOpacity(.3),
//              child: Image.asset('assets/images/aa.jpg', width: 150, height: 150),
//            ),
//            SizedBox(
//              width: 30,
//            ),
//            Image.asset(
//              'assets/images/aa.jpg',
//              width: 150,
//              height: 150,
//              fit: BoxFit.none,
//              alignment: Alignment.centerRight,
//            ),
//          ],
//        ),
//        Container(
//          color: Colors.red.withOpacity(.3),
//          child: Image.asset(
//            'assets/images/aa.jpg',
//            width: 150,
//            height: 150,
//            alignment: Alignment.centerLeft,
//          ),
//        ),

//        Expanded(
//          child: _buildGrid(),
//        ),
//        Container(
//          color: Colors.red.withOpacity(.3),
//          child: Image.asset(
//            'assets/images/aa.jpg',
//            width: 150,
//            height: 150,
//          ),
//        ),
//        Expanded(
//          child: _buildBlendModeGrid(),
//        ),
//        Image.asset(
//          'assets/images/aa.jpg',
//          width: double.infinity,
//          height: 150,
//          repeat: ImageRepeat.repeatX,
//        ),
//        Row(
//          children: <Widget>[
//            Image.asset(
//              'assets/images/logo.png',
//              height: 150,
//            ),
//            SizedBox(
//              width: 20,
//            ),
//            Directionality(
//                textDirection: TextDirection.rtl,
//                child: Image.asset(
//                  'assets/images/logo.png',
//                  height: 150,
//                  matchTextDirection: true,
//                )),
//          ],
//        ),
//        Row(
//          children: <Widget>[
//            Image.asset(
//              'assets/images/logo1.jpeg',
//              height: 150,
//              width: 150,
//              filterQuality: FilterQuality.high,
//            ),
//            SizedBox(
//              width: 20,
//            ),
//            Image.asset(
//              'assets/images/logo1.jpeg',
//              height: 150,
//              width: 150,
//              filterQuality: FilterQuality.low,
//            )
//          ],
//        ),
//        Container(
//            width: 250,
//            height: 300,
//            decoration: BoxDecoration(
//                image: DecorationImage(
//                    image: AssetImage(
//                      'assets/images/abc.jpg',
//                    ),
//                    fit: BoxFit.fill))),
        Container(
            width: 250,
            height: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    centerSlice: Rect.fromLTRB(20, 20, 21, 21),
                    image: AssetImage(
                      'assets/images/abc.jpg',
                    ),
                    fit: BoxFit.fill))),
//        Image.network(
//          'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
//          height: 150,
//          width: 150,
//          fit: BoxFit.cover,
//          frameBuilder: (
//            BuildContext context,
//            Widget child,
//            int frame,
//            bool wasSynchronouslyLoaded,
//          ) {
//            if (frame == null) {
//              return Image.asset(
//                'assets/images/place.png',
//                height: 150,
//                width: 150,
//                fit: BoxFit.cover,
//              );
//            }
//            return child;
//          },
//        ),
//        Image.network(
//          'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
//          frameBuilder: (BuildContext context, Widget child, int frame,
//              bool wasSynchronouslyLoaded) {
//            if (wasSynchronouslyLoaded) {
//              return child;
//            }
//            return AnimatedOpacity(
//              child: child,
//              opacity: frame == null ? 0 : 1,
//              duration: const Duration(seconds: 2),
//              curve: Curves.easeOut,
//            );
//          },
//        ),

//        Image.network(
//            'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
//            loadingBuilder: (BuildContext context, Widget child,
//                ImageChunkEvent loadingProgress) {
//          if (loadingProgress == null) {
//            return child;
//          }
//          return Center(
//            child: CircularProgressIndicator(
//              value: loadingProgress.expectedTotalBytes != null
//                  ? loadingProgress.cumulativeBytesLoaded /
//                      loadingProgress.expectedTotalBytes
//                  : null,
//            ),
//          );
//        }),
      ],
    );
  }

  _buildGrid() {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 30, crossAxisSpacing: 5),
      children: <Widget>[
        Container(
          color: Colors.red.withOpacity(.3),
          child: Image.asset(
            'assets/images/aa.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          color: Colors.red.withOpacity(.3),
          child: Image.asset('assets/images/aa.jpg', fit: BoxFit.contain),
        ),
        Container(
          color: Colors.red.withOpacity(.3),
          child: Image.asset('assets/images/aa.jpg', fit: BoxFit.cover),
        ),
        Container(
          color: Colors.red.withOpacity(.3),
          child: Image.asset('assets/images/aa.jpg', fit: BoxFit.fitWidth),
        ),
        Container(
          color: Colors.red.withOpacity(.3),
          child: Image.asset('assets/images/aa.jpg', fit: BoxFit.fitHeight),
        ),
        Container(
          color: Colors.red.withOpacity(.3),
          child: Image.asset('assets/images/aa.jpg', fit: BoxFit.scaleDown),
        ),
        Container(
          color: Colors.red.withOpacity(.3),
          child: Image.asset(
            'assets/images/aa.jpg',
            fit: BoxFit.none,
            alignment: Alignment.centerRight,
          ),
        ),
      ],
    );
  }

  _buildBlendModeGrid() {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 30, crossAxisSpacing: 5),
      children: <Widget>[
        _buildBlendGridItem(BlendMode.clear),
        _buildBlendGridItem(BlendMode.src),
        _buildBlendGridItem(BlendMode.dst),
        _buildBlendGridItem(BlendMode.srcOver),
        _buildBlendGridItem(BlendMode.dstOver),
        _buildBlendGridItem(BlendMode.srcIn),
        _buildBlendGridItem(BlendMode.dstIn),
        _buildBlendGridItem(BlendMode.srcOut),
        _buildBlendGridItem(BlendMode.dstOut),
        _buildBlendGridItem(BlendMode.srcATop),
        _buildBlendGridItem(BlendMode.dstATop),
        _buildBlendGridItem(BlendMode.xor),
        _buildBlendGridItem(BlendMode.plus),
        _buildBlendGridItem(BlendMode.modulate),
        _buildBlendGridItem(BlendMode.screen),
        _buildBlendGridItem(BlendMode.overlay),
        _buildBlendGridItem(BlendMode.darken),
        _buildBlendGridItem(BlendMode.lighten),
        _buildBlendGridItem(BlendMode.colorDodge),
        _buildBlendGridItem(BlendMode.colorBurn),
        _buildBlendGridItem(BlendMode.hardLight),
        _buildBlendGridItem(BlendMode.softLight),
        _buildBlendGridItem(BlendMode.difference),
        _buildBlendGridItem(BlendMode.exclusion),
        _buildBlendGridItem(BlendMode.multiply),
        _buildBlendGridItem(BlendMode.hue),
        _buildBlendGridItem(BlendMode.saturation),
        _buildBlendGridItem(BlendMode.color),
        _buildBlendGridItem(BlendMode.luminosity)
      ],
    );
  }

  _buildBlendGridItem(BlendMode blendMode) {
    return GridTile(
      child: Image.asset(
        'assets/images/aa.jpg',
        color: Colors.purple,
        colorBlendMode: blendMode,
      ),
      footer: Center(
        child: Text(
          '$blendMode'.substring(10),
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
