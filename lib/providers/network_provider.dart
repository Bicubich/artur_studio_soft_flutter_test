import 'dart:convert';

import 'package:artur_studio_soft_flutter_test/models/weather.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class NetworkProvider {
  Future<Weather?> fetchWeatherData(String city) async {
    var url = Uri.parse("https://api.api-ninjas.com/v1/weather?city=$city");

    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-Api-Key": "Y2zQjUi2A/s1qHbdkd27bQ==W97TacgUPXzCD5a3",
    });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Weather.fromJson(jsonResponse);
    }

    return null;
  }
}
