import 'dart:collection';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:covid19_mobileapp/utils.dart';
import 'dart:convert';
import 'country.dart';
import 'date.dart';

class JSONParser {
  /* fetch the json from the web */
  Future<String> fetchJSON() async {
    const url = "https://pomber.github.io/covid19/timeseries.json";
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        /* fetching was a success so return the JSON as a string */
        return response.body.toString();
      } else {
        /* fetching failed => return null */
        Utils.printDebug(
            'JSON PARSER REQUEST FAILED WITH CODE: ${response.statusCode}.');
        return null;
      }
    } on SocketException {
      /* error */
      Utils.printDebug('JSON PARSER REQUEST FAILED');
      return null;
    }
  }

  /* returns a countries map object from a json string with the country name */
  static Map<String, Country> getCountriesfromJSON(String json_string) {
    Map<String, Country> countries = new Map<String, Country>();
    Map<String, dynamic> json = jsonDecode(json_string);
    json.forEach((String country_name, dynamic country_values) {
      Map<int, Date> dates = new Map<int, Date>();
      int i = 0;
      country_values.forEach((dynamic value) {
        dates[i] = new Date(value["date"].toString(), value["confirmed"] as int,
            value["deaths"] as int, value["recovered"] as int);
        Country country = new Country(country_name, dates);
        countries[country.name] = country;
        i++;
      });
    });
    return countries;
  }
}
