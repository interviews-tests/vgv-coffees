import 'package:flutter/foundation.dart';

class Coffee {
  final String imageUrl;
  final Uint8List? imageData;

  Coffee({required this.imageUrl, this.imageData});

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      imageUrl: json['file'],
    );
  }
}
