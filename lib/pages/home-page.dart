import 'dart:convert';
import 'package:covid19_app/pages/details-page.dart';
import 'package:covid19_app/provider/covid-provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as Http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List countryData;
  bool isLoading = true;

  Future<String> getData() async {
    final url = "https://disease.sh/v3/covid-19/countries";
    try {
      final response = await Http.get(
        Uri.parse(url),
      );

      setState(
        () {
          countryData = jsonDecode(response.body);
          isLoading = false;
        },
      );
    } catch (err) {
      throw err;
    }
    return 'success';
  }

  @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Worldwide Covid Info',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .30,
                                child: Consumer<CovidDataProvider>(
                                  builder: (context, proObj, _) =>
                                      ListView.builder(
                                    itemCount: 4,
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(left: 10.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .35,
                                          child: Column(
                                            children: [
                                              Text(
                                                '',
                                                style: GoogleFonts.ubuntu(
                                                  textStyle: TextStyle(
                                                    color: Colors.blueGrey[600],
                                                    fontSize: 22.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
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
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                itemCount: countryData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CovidDetails(
                                            updated: countryData[index]
                                                ['updated'],
                                            countryName:
                                                '${countryData[index]["country"]}',
                                            flag:
                                                '${countryData[index]["countryInfo"]['flag']}',
                                            cases: countryData[index]['cases']
                                                .toString(),
                                            recovered: countryData[index]
                                                    ['recovered']
                                                .toString(),
                                            deaths: countryData[index]['deaths']
                                                .toString(),
                                            active: countryData[index]['active']
                                                .toString(),
                                            recoveredToday: countryData[index]
                                                    ['todayRecovered']
                                                .toString(),
                                            todayDeaths: countryData[index]
                                                    ['todayDeaths']
                                                .toString(),
                                            casesToday: countryData[index]
                                                    ['todayCases']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: 10.0,
                                      ),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.purple[100],
                                      ),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Image.network(
                                                  countryData[index]
                                                      ['countryInfo']['flag'],
                                                  height: 60,
                                                  width: 60,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '${countryData[index]['country']}',
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
                                                          'Cases : ${countryData[index]['cases']}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              color: Colors
                                                                  .brown[600],
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(
                                                          'Deaths : ${countryData[index]['deaths']}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              color: Colors
                                                                  .red[800],
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Recovered : ${countryData[index]['recovered']}',
                                                      style:
                                                          GoogleFonts.poppins(
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
            ),
    );
  }
}
