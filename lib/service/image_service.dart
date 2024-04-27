import 'dart:convert';

import 'package:image_app/datamodel/image_datamodel.dart';
import 'package:http/http.dart' as http;
Future<ImageData> fetchData() async {
  final url = 'https://dummyjson.com/products/1';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return  ImageData.fromJson(data);
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Failed to fetch data');
  }
}
