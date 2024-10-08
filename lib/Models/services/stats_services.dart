import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Models/services/utilities/app_url.dart';
class StatsServices {
  Future<worldStats> fetchWorldStatsRecord() async{
    final response=await http.get(Uri.parse(AppUrl.worldStatsApi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return worldStats.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> fetchCountriesList()async{
    var data;
    final response=await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      data= jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }
  }
  
}