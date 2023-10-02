import 'dart:convert';

import 'package:artur_studio_soft_flutter_test/models/weather.dart';
import 'package:artur_studio_soft_flutter_test/providers/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    home: WeatherPage(),
  ));
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late TextEditingController _textEditingController;
  List<String> citiesList = [];
  List<String> filteredCitiesList = [];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  Future<List<String>> loadJsonCities() async {
    String jsonString = await rootBundle.loadString('assets/jsons/cities.json');

    List<dynamic> jsonData = json.decode(jsonString);

    List<String> namesList =
        jsonData.map((item) => item['name'].toString()).toList();

    return namesList;
  }

  void filterSuggestionsCity(String query) {
    setState(() {
      filteredCitiesList = citiesList
          .where((suggestion) =>
              suggestion.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (citiesList.isEmpty) {
      return FutureBuilder<List<String>>(
        future: loadJsonCities(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<String>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              citiesList = snapshot.data!;
              return _buildContent();
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      );
    } else {
      return _buildContent();
    }
  }

  Widget foo() {
    return FutureBuilder<Weather?>(
      future: NetworkProvider().fetchWeatherData('Moscow'),
      builder: (
        BuildContext context,
        AsyncSnapshot<Weather?> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return _buildContent(snapshot.data);
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

  Scaffold _buildContent(Weather? weatherData) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            TextField(
              autofocus: citiesList.isNotEmpty,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide:
                      BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
                ),
                labelText: 'Город',
                hintText: 'Введите город...',
                labelStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              controller: _textEditingController,
              onChanged: (query) {
                if (query.length >= 2) {
                  filterSuggestionsCity(query);
                } else {
                  setState(() {
                    filteredCitiesList = [];
                  });
                }
              },
            ),
            Visibility(
              visible: filteredCitiesList.isNotEmpty,
              child: Expanded(
                child: ListView.builder(
                  itemCount: filteredCitiesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredCitiesList[index]),
                      onTap: () {
                        setState(() {
                          _textEditingController.text =
                              filteredCitiesList[index].toString();
                          filteredCitiesList = [];
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
