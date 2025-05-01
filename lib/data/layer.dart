import 'package:flutter/material.dart';
import 'package:image_editor_plus/data/image_item.dart';

/// Layer class with some common properties
class Layer {
  Offset offset;
  double rotation, scale, opacity;

  Layer({
    this.offset = const Offset(64, 64),
    this.opacity = 1,
    this.rotation = 0,
    this.scale = 1,
  });

  copyFrom(Map json) {
    offset = Offset(json['offset'][0], json['offset'][1]);
    opacity = json['opacity'];
    rotation = json['rotation'];
    scale = json['scale'];
  }

  static Layer fromJson(Map json) {
    switch (json['type']) {
      case 'BackgroundLayer':
        return BackgroundLayerData.fromJson(json);
      case 'EmojiLayer':
        return EmojiLayerData.fromJson(json);
      case 'ImageLayer':
        return ImageLayerData.fromJson(json);
      case 'LinkLayer':
        return LinkLayerData.fromJson(json);
      case 'TextLayer':
        return TextLayerData.fromJson(json);
      case 'BackgroundBlurLayer':
        return BackgroundBlurLayerData.fromJson(json);
      default:
        return Layer();
    }
  }

  Map toJson() {
    return {
      'offset': [offset.dx, offset.dy],
      'opacity': opacity,
      'rotation': rotation,
      'scale': scale,
    };
  }
}

/// Attributes used by [BackgroundLayer]
class BackgroundLayerData extends Layer {
  ImageItem image;

  BackgroundLayerData({
    required this.image,
  });

  static BackgroundLayerData fromJson(Map json) {
    return BackgroundLayerData(
      image: ImageItem.fromJson(json['image']),
    );
  }

  @override
  Map toJson() {
    return {
      'type': 'BackgroundLayer',
      'image': image.toJson(),
    };
  }
}

/// Attributes used by [EmojiLayer]
class EmojiLayerData extends Layer {
  String text;
  double size;

  EmojiLayerData({
    this.text = '',
    this.size = 64,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
  });
}

/// Attributes used by [ImageLayer]
class ImageLayerData extends Layer {
  ImageItem image;
  double size;

  ImageLayerData({
    required this.image,
    this.size = 64,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
  });
}

/// Attributes used by [TextLayer]
class TextLayerData extends Layer {
  String text;
  double size;
  Color color, background;
  double backgroundOpacity;
  TextAlign align;

  TextLayerData({
    required this.text,
    this.size = 64,
    this.color = Colors.white,
    this.background = Colors.transparent,
    this.backgroundOpacity = 0,
    this.align = TextAlign.left,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
  });
}

/// Attributes used by [BackgroundBlurLayer]
class BackgroundBlurLayerData extends Layer {
  Color color;
  double radius;

  BackgroundBlurLayerData({
    required this.color,
    required this.radius,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
  });
}
