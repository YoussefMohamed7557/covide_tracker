import 'dart:convert';

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
}