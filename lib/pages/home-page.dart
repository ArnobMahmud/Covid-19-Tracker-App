import 'dart:convert';
import 'package:covid19_app/pages/details-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as Http;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // CovidProvider covidProvider;
  // bool isLoading = true;

  // @override
  // void didChangeDependencies() {
  //   covidProvider = Provider.of<CovidProvider>(context, listen: false);
  //   covidProvider.fetchCovideData().then(
  //         (_) => {
  //           setState(
  //             () {
  //               isLoading = false;
  //             },
  //           )
  //         },
  //       );
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[50],
        elevation: 0,
        title: Text(
          'Covid\'19 Tracker App',
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.blueGrey,
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: Http.get(
          Uri.parse('https://disease.sh/v3/covid-19/countries/'),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List data = jsonDecode(snapshot.data.body);
          List country = [];
          List countryInfo = [];
          List cases = [];
          List todayCases = [];
          List deaths = [];
          List todayDeaths = [];
          List recovered = [];
          List todayRecovered = [];
          List active = [];
          List critical = [];
          List casesPerOneMillion = [];
          List deathsPerOneMillion = [];
          List tests = [];
          List testsPerOneMillion = [];
          data.forEach(
            (element) {
              country.add(element["country"]);
              countryInfo.add(element['countryInfo']);
              cases.add(element['cases']);
              todayCases.add(element['todayCases']);
              deaths.add(element['deaths']);
              todayDeaths.add(element['todayDeaths']);
              recovered.add(element['recovered']);
              todayRecovered.add(element['todayRecovered']);
              active.add(element['active']);
              critical.add(element['critical']);
              casesPerOneMillion.add(element['casesPerOneMillion']);
              deathsPerOneMillion.add(element['deathsPerOneMillion']);
              tests.add(element['tests']);
              testsPerOneMillion.add(element['testsPerOneMillion']);
              deathsPerOneMillion.add(element['deathsPerOneMillion']);
            },
          );

          print(data);
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * .25,
                color: Colors.amber[50],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Novel Corona\nVirus',
                            style: TextStyle(
                              color: Colors.teal[800],
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Stay Home Stay Safe',
                            style: TextStyle(
                              color: Colors.brown[800],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      'images/covid_logo.png',
                      width: MediaQuery.of(context).size.width * .38,
                      height: MediaQuery.of(context).size.height * .25,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //color: Colors.red[300],
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              //color: Colors.blue[100],
                              height: MediaQuery.of(context).size.height * .30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(left: 10.0),
                                itemCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .30,
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Column(
                                        children: [
                                          Text(country[index]),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CovidDetails(
                                          countryName: '${country[index]}',
                                          flag: '${countryInfo[index]['flag']}',
                                          cases: cases[index].toString(),
                                          recovered:
                                              recovered[index].toString(),
                                          deaths: deaths[index].toString(),
                                          tests: tests[index].toString(),
                                          active: active[index].toString(),
                                          recoveredToday:
                                              todayRecovered[index].toString(),
                                          todayDeaths:
                                              todayDeaths[index].toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: 15.0, right: 10.0),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.purple[100],
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Image.network(
                                                countryInfo[index]['flag'],
                                                height: 60,
                                                width: 60,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '${country[index]}',
                                                    style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                        color: Colors
                                                            .blueGrey[600],
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        'Cases : ${cases[index]}',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            color: Colors
                                                                .brown[600],
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        'Deaths : ${deaths[index]}',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            color:
                                                                Colors.red[800],
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Recovered : ${recovered[index]}',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                        color:
                                                            Colors.green[800],
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
