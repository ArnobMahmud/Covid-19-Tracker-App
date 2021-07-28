import 'dart:convert';
import 'package:covid19_app/models/world-covid-model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

class CovidDataProvider extends ChangeNotifier {
  CovidData _covidData;
  CovidData get getCovidData => _covidData;
  Future fetchCovidData() async {
    try {
      final url = "https://disease.sh/v3/covid-19/all/";
      final response = await Http.get(
        Uri.parse(url),
      );
      final responseMap = jsonDecode(response.body);
      print(responseMap);
      _covidData = CovidData.fromJson(responseMap);
    } catch (err) {
      throw err;
    }
  }
}
