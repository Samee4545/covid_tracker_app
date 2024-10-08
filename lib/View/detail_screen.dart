import 'package:covid_tracker/world_states.dart';
import 'package:flutter/material.dart';

class detailScreen extends StatefulWidget {
  String image, name;
  int totalCases, totalDeaths, totalRecovered,active,critical,todayRecovered, test;
   detailScreen({
    required this.image, 
    required this.name, 
    required this.totalCases,
    required this.totalRecovered,
    required this.totalDeaths, 
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test
    }
  );


  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067, left: 15, right: 15),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06),
                      ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                      ReusableRow(title: 'Active Cases', value: widget.active.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),

    );
  }
}