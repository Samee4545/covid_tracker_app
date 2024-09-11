import 'package:covid_tracker/Models/services/stats_services.dart';
import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class worldStatesScreen extends StatefulWidget {
  const worldStatesScreen({Key? key}) : super(key: key);

  @override
  State<worldStatesScreen> createState() => _worldStatesScreenState();
}

class _worldStatesScreenState extends State<worldStatesScreen>
    with TickerProviderStateMixin {
  @override
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color.fromARGB(255, 23, 112, 255),
    Color.fromARGB(255, 39, 203, 10),
    Color.fromARGB(255, 255, 26, 5),
  ];

  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
      
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            FutureBuilder(
                future: statsServices.fetchWorldStatsRecord(),
                builder: (context, AsyncSnapshot<worldStats> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered!.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: 'Total',
                                    value: snapshot.data!.cases!.toString()),
                                ReusableRow(
                                    title: 'Recovered',
                                    value:
                                        snapshot.data!.recovered!.toString()),
                                ReusableRow(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths!.toString()),
                                ReusableRow(
                                    title: 'Active',
                                    value: snapshot.data!.active!.toString()),
                                ReusableRow(
                                    title: 'Critical',
                                    value: snapshot.data!.critical!.toString()),
                                ReusableRow(
                                    title: 'Today Cases',
                                    value:
                                        snapshot.data!.todayCases!.toString()),
                                ReusableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered!
                                        .toString()),
                                ReusableRow(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths!.toString())
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>countriesListSceen()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 39, 203, 10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ]),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
