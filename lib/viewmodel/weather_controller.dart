import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_provider/model/weather_model.dart';
import 'package:flutter_weather_provider/service/api_service.dart';

class WeatherController extends ChangeNotifier {
  late WeatherDataModel _weatherModel;

  WeatherDataModel get weatherModel => _weatherModel;

  Statuses status = Statuses.stopped;

  getCurrentWeatherByCity({required String city}) async {
    try {
      status = Statuses.trying;
      var data = await APIService().getWeatherByCity(city);
      if (data == null) {
        status = Statuses.receivedNull;
        notifyListeners();
      } else {
        _weatherModel = data;

        status = Statuses.successful;
        notifyListeners();
      }
    } catch (e) {
      status = Statuses.error;
      print(e.toString());
    }
  }
}

enum Statuses { stopped, successful, error, trying, receivedNull }
