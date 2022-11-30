import '/pages/statistic_page.dart';
import 'package:flutter/material.dart';

import '../services/entities.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({Key? key}) : super(key: key);

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  final HttpService httpService = HttpService();
  List<Country> countries = [];
  //bool connected = false;

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("COVID-19 Real-time Info"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: FutureBuilder(
          future: httpService.getCountries(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == false) {
                return const Center(
                  child: Text(
                    "Vous n'avez pas accès à internet",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
              countries = snapshot.data as List<Country>;
              return Column(
                children: [
                  // Container(
                  //   height: 50,
                  //   width: screenWidth - 35,
                  //   margin: const EdgeInsets.symmetric(horizontal: 15),
                  //   child: Container(
                  //       color: Colors.white70,
                  //       padding: const EdgeInsets.symmetric(horizontal: 15),
                  //       child: TextField(
                  //         style: TextStyle(fontSize: 18),
                  //         decoration:
                  //             InputDecoration(suffixIcon: Icon(Icons.search)),

                  //       )),
                  // ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      child: ListView(
                        children: countries
                            .map(
                              (e) => Container(
                                height: 50,
                                width: double.maxFinite,
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey,
                                ),
                                child: TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => StatisticPage(
                                                country: e,
                                              ))),
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              //debugPrint('Accès Internet : ${internetAccess}');
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
      ),
    );
  }
}
