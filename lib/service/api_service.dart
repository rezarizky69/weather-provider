import 'dart:convert';

import 'package:flutter_weather_provider/model/weather_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  Future<dynamic> getWeatherByCity(String city) async {
    // String url =
    //     'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=c847913a01caff9f6e39cc7ad382a3e7&units=metric';
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=c847913a01caff9f6e39cc7ad382a3e7&units=metric'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WeatherDataModel.fromJson(data);
    } else {
      print('\n\n response is failed \n\n');
      print(response.statusCode);
      return null;
    }
  }
}
