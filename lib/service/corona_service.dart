import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// https://github.com/OssamaRafique/Corona-Statistics-And-Tracker-Dashboard-Angular-9
// http://api.coronastatistics.live/countries/[country-name]

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

  if (response.statusCode == HttpStatus.ok) {
    log(response.body.toString());
    return compute(parseCountryStats, response.body);
  } else {
    throw Exception("failed to load data");
  }
}

List<CountryStats> parseCountryStats(String response) {
  final parsed = json.decode(response).cast<Map<String, dynamic>>();
  return parsed
      .map<CountryStats>((json) => CountryStats.fromJson(json))
      .toList();
}
