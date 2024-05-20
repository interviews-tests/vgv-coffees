import 'dart:convert';

import 'package:vgvcoffees/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:vgvcoffees/models/coffee.dart';

class CoffeeRepository {
  Future<Coffee> fetchCoffeeImages() async {
    final response = await http.get(Uri.parse(Constants.coffeeApiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final coffeeImageUrl = data['file'] as String;
      final coffee = Coffee(imageUrl: coffeeImageUrl);
      return coffee;
    } else {
      throw Exception('Failed to load coffee images');
    }
  }

  Future<String> fetchImageAsBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      return base64Encode(bytes);
    } else {
      throw Exception('Failed to load image as Base64');
    }
  }
}

