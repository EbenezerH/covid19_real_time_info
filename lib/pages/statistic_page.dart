import 'package:flutter/material.dart';

import '../services/entities.dart';
import '../widgets/line_info.dart';
import '../widgets/title_table.dart';

class StatisticPage extends StatefulWidget {
  final Country country;
  const StatisticPage({Key? key, required this.country}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  final HttpService httpService = HttpService();

  late Statistic _statistic;

  //WindowState _windowState = WindowState.home_screen;

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("COVID-19 Real-time Info"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: httpService.getStatistic(widget.country),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == false) {
              return const Center(
                child: Text(
                  "Vous n'avez pas accès à internet",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            _statistic = snapshot.data as Statistic;
            return Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(
                            "img/img6.jpg",
                          ),
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.bottomCenter),
                      color: Colors.lightBlue.withOpacity(0.4),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          //General info
                          TitleTable(
                            label: 'Country',
                            text: _statistic.country,
                            color: Colors.blue,
                          ),
                          LigneInfo(
                            label: 'Continent',
                            text: _statistic.continent,
                          ),
                          LigneInfo(
                            label: 'Population',
                            text: "${_statistic.population}",
                          ),

                          //Cases
                          TitleTable(
                            label: 'Case',
                            text: "${_statistic.cases['total']}",
                            //color: Colors.blue,
                          ),
                          LigneInfo(
                            label: 'New',
                            text: _statistic.cases['new'].toString() != "null"
                                ? _statistic.cases['new'].toString()
                                : "- - -",
                          ),
                          LigneInfo(
                            label: 'Active',
                            text: "${_statistic.cases['active']}",
                          ),
                          LigneInfo(
                            label: 'Recorvred',
                            text: _statistic.cases['recorvred'].toString() !=
                                    "null"
                                ? _statistic.cases['recorvred'].toString()
                                : "- - -",
                          ),
                          LigneInfo(
                            label: 'Critical',
                            text: _statistic.cases['critical'].toString() !=
                                    "null"
                                ? _statistic.cases['critical'].toString()
                                : "- - -",
                          ),

                          //Deaths
                          TitleTable(
                            label: "Deaths",
                            color: const Color.fromARGB(255, 165, 12, 1),
                            text:
                                _statistic.deaths['total'].toString() != "null"
                                    ? _statistic.deaths['total'].toString()
                                    : "- - -",
                          ),
                          LigneInfo(
                            label: 'New',
                            text: _statistic.deaths['new'].toString() != "null"
                                ? _statistic.deaths['new'].toString()
                                : "- - -",
                          ),

                          //Tests
                          TitleTable(
                            label: "Tests",
                            text: _statistic.tests['total'].toString() != "null"
                                ? _statistic.tests['total'].toString()
                                : "- - -",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text(
                      "Connecting...",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ));
          }
        },
      ),
    );
  }
}
