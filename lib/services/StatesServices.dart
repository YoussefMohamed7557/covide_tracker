import 'dart:convert';

import 'package:covid_tracker/model/CountriesStatesModel.dart';
import 'package:covid_tracker/services/utilities/app_urls.dart';
import 'package:covid_tracker/model/WorldStatesModel.dart';
import 'package:http/http.dart' as http;
class StatesServices{
  Future<WorldStatesModel> getWorldStatesApiData() async{
    final response =await http.get(Uri.parse(AppUrls.worldStatesApi));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return WorldStatesModel.fromJson(data as Map<String,dynamic>);
    }else{
      throw Exception('Error');
    }
  }
  // Future<List<CountriesStatesModel>> getCountriesListApiData() async{
  //   List<CountriesStatesModel> countries = [];
  //   final response =await http.get(Uri.parse(AppUrls.countriesList));
  //   var data = jsonDecode(response.body.toString());
  //   if(response.statusCode == 200){
  //     countries.clear();
  //     for(Map<String,dynamic> item in data){
  //       countries.add(CountriesStatesModel.fromJson(item));
  //     }
  //     return countries;
  //   }else{
  //     return countries;
  //   }
  // }
  Future<List<dynamic>> getCountriesListApiData() async{
    var data ;
    final response =await http.get(Uri.parse(AppUrls.countriesList));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }
  }
}