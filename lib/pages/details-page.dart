import 'package:covid19_app/config/const.dart';
import 'package:covid19_app/pages/home-page.dart';
import 'package:covid19_app/widgets/show-covid-info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CovidDetails extends StatelessWidget {
  final int updated;
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
      this.casesToday,
      this.updated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
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
        title: Flexible(
          child: Text(
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
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green[50],
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
                Flexible(
                  child: Text(
                    '$countryName',
                    style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                        color: Colors.blueGrey[600],
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Last Updated on\n${getFormattedDate(updated, 'hh:mm a')}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      color: Colors.teal[300],
                      fontSize: 24.0,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
