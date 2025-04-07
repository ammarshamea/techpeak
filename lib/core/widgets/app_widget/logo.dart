import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../app_size/app_size.dart';
import '../../constante/app_image.dart';

class Logo extends StatelessWidget {
  final String Image;
  const Logo({
    super.key, required this.Image,
  });

  @override
  Widget build(BuildContext context) {
    return ImageMultiType(
      url: Image,
      width: width(context) * 0.75,
      height: height(context) * 0.4,
      fit: BoxFit.cover,
    );
  }
}