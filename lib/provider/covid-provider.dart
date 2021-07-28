import 'dart:convert';
import 'package:covid19_app/models/covid-data-model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

class CovidProvider extends ChangeNotifier {
  CovidData _covidData;

  CovidData get getCovidData => _covidData;

  Future fetchCovideData() async {
    final url = 'https://disease.sh/v3/covid-19/all';
    try {
      final response = await Http.get(
        Uri.parse(url),
      );
      final responseMap = jsonDecode(response.body);
      print(response.body);
      _covidData = CovidData.fromJson(responseMap);
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }
}
