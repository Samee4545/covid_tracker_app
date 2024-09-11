import 'package:covid_tracker/Models/services/utilities/app_url.dart';
import 'package:covid_tracker/Models/services/stats_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class countriesListSceen extends StatefulWidget {
  const countriesListSceen({Key? key}) : super(key: key);

  @override
  State<countriesListSceen> createState() => _countriesListSceenState();
}

class _countriesListSceenState extends State<countriesListSceen> {
  @override
  TextEditingController searchController= TextEditingController();
  Widget build(BuildContext context) {
    StatsServices statsServices=StatsServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
            
                  )
                ),
                onChanged: (value){
                  setState(() {
                    
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.fetchCountriesList(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index){
                        return Shimmer.fromColors(                        
                          baseColor: Colors.grey.shade700, 
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                        children: [
                          ListTile(
                            leading: Container(height: 50, width: 50, color: Colors.white,),
                              title: Container(height: 10, width: 89, color: Colors.white,),
                              subtitle: Container(height: 10, width: 89, color: Colors.white,),
                          )
                        ],
                       ), 
                          );
                        
                  });
                  }
                  else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        String name=snapshot.data![index]['country'];
                        if(searchController.text.isEmpty){
                          return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>detailScreen(
                                image: snapshot.data![index]['countryInfo']['flag'], 
                                name: snapshot.data![index]['country'], 
                                totalCases: snapshot.data![index]['cases'], 
                                totalRecovered: snapshot.data![index]['recovered'], 
                                totalDeaths: snapshot.data![index]['deaths'], 
                                active: snapshot.data![index]['active'], 
                                critical: snapshot.data![index]['critical'], 
                                todayRecovered: snapshot.data![index]['todayRecovered'], 
                                test: snapshot.data![index]['tests']
                                )
                                )
                                );
                            },
                            child: ListTile(
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                            ),
                          )
                        ],
                       );
                        }
                        else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                           return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>detailScreen(
                                image: snapshot.data![index]['countryInfo']['flag'], 
                                name: snapshot.data![index]['country'], 
                                totalCases: snapshot.data![index]['cases'], 
                                totalRecovered: snapshot.data![index]['recovered'], 
                                totalDeaths: snapshot.data![index]['deaths'], 
                                active: snapshot.data![index]['active'], 
                                critical: snapshot.data![index]['critical'], 
                                todayRecovered: snapshot.data![index]['todayRecovered'], 
                                test: snapshot.data![index]['tests']
                              )));
                            },
                            child: ListTile(
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                            ),
                          )
                        ],
                       );
                        }
                        else{
                              return Container();                      
                        }
                       
                  });
                  }

              }
              )
        )],
        )
      ),

    );
  }
}