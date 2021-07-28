import 'package:covid19_app/pages/home-page.dart';
import 'package:covid19_app/widgets/show-covid-info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CovidDetails extends StatelessWidget {
  final String updated;
  final String countryName;
  final String flag;
  final String cases;
  final String casesToday;
  final String recovered;
  final String deaths;
  final String tests;
  final String active;
  final String recoveredToday;
  final String todayDeaths;
  const CovidDetails(
      {Key key,
      this.countryName,
      this.cases,
      this.recovered,
      this.deaths,
      this.tests,
      this.active,
      this.recoveredToday,
      this.todayDeaths,
      this.flag,
      this.casesToday, this.updated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.purple[100],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
            );
          },
        ),
        title: Text(
          '$countryName Covid Updates',
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.blueGrey[600],
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(0, 2),
                  spreadRadius: -1,
                  blurRadius: 9)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  flag,
                  height: 100,
                  width: 100,
                ),
                Text(
                  '$countryName',
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CovidInfoCard(
                  title: 'Total Cases',
                  data: cases,
                  color: Colors.brown[600],
                ),
                CovidInfoCard(
                  title: 'Total Recovered',
                  data: recovered,
                  color: Colors.blue[900],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CovidInfoCard(
                  title: 'Cases Today',
                  data: casesToday,
                  color: Colors.black,
                ),
                CovidInfoCard(
                  title: 'Recovered Today',
                  data: recoveredToday,
                  color: Colors.green[900],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CovidInfoCard(
                  title: 'Total Deaths',
                  data: deaths,
                  color: Colors.red[500],
                ),
                CovidInfoCard(
                  title: 'Deaths Today',
                  data: todayDeaths,
                  color: Colors.red[900],
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
