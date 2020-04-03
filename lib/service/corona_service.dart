import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:http/http.dart' as http;

class CoronaService {
  Future<CountryStats> fetchCountryStats(String country) async {
    final endpoint = "http://api.coronastatistics.live/countries/" + country;
    final response = await http.get(endpoint);

    if (response.statusCode == HttpStatus.ok) {
      log(response.body.toString());
      return CountryStats.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load data");
    }
  }

  Future<OverallStats> fetchOverallStats() async {
    final endpoint = "http://api.coronastatistics.live/all";
    final response = await http.get(endpoint);

    if (response.statusCode == HttpStatus.ok) {
      log(response.body.toString());
      return OverallStats.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load data");
    }
  }

  Future<List<CountryStats>> fetchOverallCountryStats() async {
    final endpoint = "http://api.coronastatistics.live/countries?sort=cases";
    final response = await http.get(endpoint);
    var jsonResponse = json.decode(response.body) as List;
    return jsonResponse
        .map((countryStats) => CountryStats.fromJson(countryStats))
        .toList();
  }

  String getFlagImage(String countryName) {
    String asset = "assets/flags/";
    if (countryCode[countryName] == null) {
      asset = asset + "unknow.png";
    } else {
      asset = asset + countryCode[countryName].toLowerCase() + ".png";
    }
    return asset;
  }
}
