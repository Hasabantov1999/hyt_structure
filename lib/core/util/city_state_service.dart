import 'dart:convert';

import 'package:fast_structure/core/util/location_helper.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


import '../components/app_state_picker.dart';
import 'developer_log.dart';

class CodeFinderService {
  static CodeFinderService? _instance;

  static CodeFinderService get instance =>
      _instance ??= CodeFinderService._init();

  CodeFinderService._init();
  List<CountryModel> countryList = [];
  List<CityModel> ilIlceList = [];
  CountryModel? myCountryCode;
  Future<void> loadCountryData() async {
    try {
      var data = await rootBundle.loadString("assets/country_code.json");

      var jsonData = json.decode(data);
      jsonData.forEach((country) {
        countryList.add(CountryModel.fromJson(country));
      });
      Position position = await LocationHelper.instance.determinePosition();
      myCountryCode = await _getCountryCodeName(position);
      DeveloperLog.instance.logSuccess("${myCountryCode?.toJson()}");
    } catch (e) {
      DeveloperLog.instance.logError("Country Code dıd not found");
    }
  }

  Future<CountryModel?> _getCountryCodeName(Position position) async {
    try {
      List<Placemark> address =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark = address.first;
      String country = placeMark.isoCountryCode!;
      return countryList
          .firstWhere((element) => element.countryCode == country);
      // ignore: empty_catches
    } catch (e) {}

    return null;
  }


}

class CountryModel {
  String? countryCode;
  String? name;
  String? callingCode;
  String? flag;

  CountryModel({this.countryCode, this.name, this.callingCode, this.flag});

  CountryModel.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    name = json['name'];
    callingCode = json['calling_code'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = countryCode;
    data['name'] = name;
    data['calling_code'] = callingCode;
    data['flag'] = flag;
    return data;
  }
}
