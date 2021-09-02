import 'package:flutter/material.dart';
import 'package:flutter_weather_provider/model/weather_model.dart';
import 'package:flutter_weather_provider/view/widget/widget.dart';
import 'package:flutter_weather_provider/viewmodel/weather_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.cloud,
          color: Colors.lightBlueAccent,
        ),
        title: Text(
          'Weather App',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: Colors.lightBlueAccent,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 250.0,
                    height: 60.0,
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 2),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.shade100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 5,
                          spreadRadius: 2,
                          // blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: TextField(
                          controller: _textEditingController,
                          autofocus: true,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          onSubmitted: (_) {
                            if (_textEditingController.text.isNotEmpty &&
                                _textEditingController.text != null) {
                              Provider.of<WeatherController>(context,
                                      listen: false)
                                  .getCurrentWeatherByCity(
                                      city: _textEditingController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Getting Data"),
                                  backgroundColor: Colors.lightBlueAccent,
                                ),
                              );
                              FocusScope.of(context).unfocus();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Empty Fields!"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 4.0),
                            prefixText: '  ',
                            border: InputBorder.none,
                            hintText: 'Enter city name',
                            hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                            suffix: IconButton(
                              icon: Icon(
                                Icons.search_sharp,
                                size: 18,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (_textEditingController.text.isNotEmpty &&
                                    _textEditingController.text != null) {
                                  Provider.of<WeatherController>(context,
                                          listen: false)
                                      .getCurrentWeatherByCity(
                                          city: _textEditingController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Getting Data"),
                                      backgroundColor: Colors.lightBlueAccent,
                                    ),
                                  );
                                  FocusScope.of(context).unfocus();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Empty Fields!"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  getStatusWidget(
                      context,
                      Provider.of<WeatherController>(context, listen: true)
                          .status),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getStatusWidget(context, Statuses _status) {
    // when status == stopped
    if (_status == Statuses.stopped) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Insert your city name',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    // when status == trying
    else if (_status == Statuses.trying) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Getting data'),
          ),
          CircularProgressIndicator(),
        ],
      );
    }
    // when status == received null
    else if (_status == Statuses.receivedNull) {
      return Column(
        children: [
          Text(
            "Received null : (",
          ),
          Text(
            "Try checking your city name",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("OR"),
          TextButton(
            child: Text(
              "Try Again",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              if (_textEditingController.text.isNotEmpty &&
                  _textEditingController.text != null) {
                Provider.of<WeatherController>(context, listen: false)
                    .getCurrentWeatherByCity(city: _textEditingController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Getting Data"),
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
                FocusScope.of(context).unfocus();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Empty Fields!"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          )
        ],
      );
    }
    // when status == error
    else if (_status == Statuses.error) {
      return Column(
        children: [
          Text(
            "Error - Check your connection",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            child: Text(
              "Try Again",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              if (_textEditingController.text.isNotEmpty &&
                  _textEditingController.text != null) {
                Provider.of<WeatherController>(context, listen: false)
                    .getCurrentWeatherByCity(city: _textEditingController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Getting Data"),
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
                FocusScope.of(context).unfocus();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Empty Fields!"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      );
      // when status == succesfull
    } else if (_status == Statuses.successful) {
      return showDataWeather(
          data: Provider.of<WeatherController>(context).weatherModel);
    } else
      return CircularProgressIndicator();
  }
}

Widget showDataWeather({required WeatherDataModel data}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        width: double.infinity,
        // height: 180,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/city.png",
              height: 100,
              width: double.infinity,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data.name.toString(),
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  //fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .95,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        shrinkWrap: true,
        children: <Widget>[
          CategoryCard(
            title: "Temperature",
            imgSrc: "assets/temperature.png",
            weather: data.main.temp.toString() + " C",
            press: () {},
          ),
          CategoryCard(
            title: "Max Temperature",
            imgSrc: "assets/max_temp.png",
            weather: data.main.tempMax.toString() + " C",
            press: () {},
          ),
          CategoryCard(
            title: "Min Temperature",
            imgSrc: "assets/min_temp.png",
            weather: data.main.tempMin.toString() + " C",
            press: () {},
          ),
          CategoryCard(
            title: "Weather Condition",
            imgSrc: "assets/weather_condition.png",
            weather: data.weather[0].main.toString(),
            press: () {},
          ),
           CategoryCard(
            title: "Feels-like",
            imgSrc: "assets/main.png",
            weather: data.main.feelsLike.toString(),
            press: () {},
          ),
           CategoryCard(
            title: "Humidity",
            imgSrc: "assets/humidity.png",
            weather: data.main.humidity.toString(),
            press: () {},
          ),
        ],
      ),
      SizedBox(height: 20,)
    ],
  );
}
