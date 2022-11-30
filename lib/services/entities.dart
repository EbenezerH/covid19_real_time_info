// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// ignore: constant_identifier_names
const String COVID_HOST = 'covid-193.p.rapidapi.com'; //Lien de base
const String RAPID_API_KEY =
    'c37e25b86dmsh3bd7692e9984f7dp1a04e4jsn4cb7488323e0'; //clé api
const List<String> PATHS = [
  '/countries',
  '/history',
  '/statistics'
]; //Liste des différents chemins de l'api

enum WindowState { home_screen, statistic_screen, history } //Les états (states)

class Country {
  //Class Country
  //required one parameter : le nom du pays
  final String name;
  Country({required this.name});
}

class Statistic {
  final String continent;
  final String country;
  final int population;
  final Map<String, dynamic> cases;
  final Map<String, dynamic> deaths;
  final Map<String, dynamic> tests;
  final DateTime time;
  Statistic(
      {required this.continent,
      required this.country,
      required this.population,
      required this.cases,
      required this.deaths,
      required this.tests,
      required this.time});

  factory Statistic.fromJson(Map<String, dynamic> json) {
    dynamic o = json['continent'];
    String cont = '', cnty = '';
    if (o != null) {
      cont = o.toString();
    }
    o = json['country'];
    if (o != null) {
      cnty = o.toString();
    }
    o = json['population'];
    /*
     * Pour les pays dont la population est indéfinie,
     * la valeur -1 est utilisée par défaut.
    */
    int pop = -1;
    if (o != null) {
      pop = o as int;
    }
    return Statistic(
        continent: cont,
        country: cnty,
        population: pop,
        cases: json['cases'] as Map<String, dynamic>,
        deaths: json['deaths'] as Map<String, dynamic>,
        tests: json['tests'] as Map<String, dynamic>,
        time: DateTime.parse(json['time']));
  }
}

class HttpService {
  //<>

  Future<dynamic> getCountries() async {
    try {
      //List<Country>
      Response res = await get(Uri.https(COVID_HOST, PATHS[0]), headers: {
        'X-Rapidapi-Key': RAPID_API_KEY,
        'X-Rapidapi-Host': COVID_HOST,
        'Host': COVID_HOST
      });
      if (res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        List<dynamic> names = body['response'];
        return names.map((e) => Country(name: e)).toList();
      } else {
        String msg = "Unable to retrieve Countries : ${res.reasonPhrase}";
        debugPrint(msg);
        throw msg;
      }
    } catch (_) {}
    return false;
  }

  Future<dynamic> getStatistic(Country country) async {
    try {
      Response res = await get(
          Uri.https(COVID_HOST, PATHS[2], {'country': country.name}),
          headers: {
            'X-Rapidapi-Key': RAPID_API_KEY,
            'X-Rapidapi-Host': COVID_HOST,
            'Host': COVID_HOST
          });
      if (res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        Statistic statistic = Statistic.fromJson(body['response'][0]);
        return statistic;
      } else {
        String msg =
            "Unable to retrieve statistic of '${country.name}' : ${res.reasonPhrase}";
        debugPrint(msg);
        throw msg;
      }
    } catch (_) {
      debugPrint(_.toString());
    }
    return false;
  }

  Future<dynamic> getStatistics() async {
    try {
      Response res = await get(Uri.https(COVID_HOST, PATHS[2]), headers: {
        'X-Rapidapi-Key': RAPID_API_KEY,
        'X-Rapidapi-Host': COVID_HOST,
        'Host': COVID_HOST
      });
      if (res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        // for (String key in body.keys) {
        //   if (!(key == 'response')) {
        //     debugPrint("$key : ${body[key]}");
        //   } else {
        //     debugPrint(body[key].runtimeType.toString());
        //   }
        // }
        List<dynamic> stats = body['response'];
        List<Statistic> statistics =
            stats.map((e) => Statistic.fromJson(e)).toList();
        return statistics;
      } else {
        String msg = "Unable to retrieve statistics : ${res.reasonPhrase}";
        debugPrint(msg);
        throw msg;
      }
    } catch (_) {}
    return false;
  }
}
