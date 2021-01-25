import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/bloc/weather_bloc.dart';
import 'package:test_flutter/model/weather.dart';

import 'widget/message.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final weatherbloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: BlocProvider<WeatherBloc>(
          create: (context) => weatherbloc,
          child: Container(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return buildInitial();
                } else if (state is WeatherLoading) {
                  return buildLoadingInput();
                } else if (state is WeatherLoaded) {
                  return buildColumnWithData(state.weather);
                }
                return Message(message: "Something Went Worng Try Again Later");
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInitial() {
    print("Initail");
    return Center(
      child: buildPadding(),
    );
  }

  Widget buildLoadingInput() {
    print("Loading");
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Column buildColumnWithData(Weather weather) {
    print("Loaded");
    return Column(
      children: [
        Text(weather.cityName),
        Text("${weather.temperature.toStringAsFixed(1)} C"),
        buildPadding(),
      ],
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: submitedCityName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            hintText: 'Enter a City', suffixIcon: Icon(Icons.search)),
      ),
    );
  }

  void submitedCityName(String name) {
    BlocProvider.of<WeatherBloc>(context).add(GetWeather(name));
  }

  @override
  void dispose() {
    super.dispose();
    weatherbloc.close();
  }
}
