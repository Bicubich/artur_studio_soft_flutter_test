// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:artur_studio_soft_flutter_test/models/weather.dart';
import 'package:http/http.dart' as http;

class NetworkProvider {
  Future<Weather?> fetchWeatherData(String city) async {
    var url = Uri.parse("https://api.api-ninjas.com/v1/weather?city=$city");

    var response = await http.get(url, headers: {
      "Accept": "application/json",
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token',
      "Authorization": "6LeSKTJUAAAAAJP9B8ZjYTQnW9zhWls2UyBcnq0W",
    });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Weather.fromJson(jsonResponse);
    }

    return null;
  }
}
