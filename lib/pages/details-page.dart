import 'dart:io';
import 'package:covid19_app/config/const.dart';
import 'package:covid19_app/pages/home-page.dart';
import 'package:covid19_app/widgets/show-covid-info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CovidDetails extends StatefulWidget {
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
  _CovidDetailsState createState() => _CovidDetailsState();
}

class _CovidDetailsState extends State<CovidDetails> {
  InterstitialAd myInterstitial;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd(); // create ad
  }

  _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910', // test ad ids for different platforms

      request: AdRequest(),

      adLoadCallback: InterstitialAdLoadCallback(
        // if ad fails to load
        onAdFailedToLoad: (LoadAdError error) {
          print('Ad exited with error: $error'); // print error
        },

        // else
        onAdLoaded: (InterstitialAd ad) {
          setState(() {
            this.myInterstitial = ad; // set the ad equal to the current ad
          });
        },
      ),
    );
  }

  _showInterstitialAd() {
    // create callbacks for ad
    myInterstitial.fullScreenContentCallback = FullScreenContentCallback(
      // when dismsissed
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        Navigator.pop(context); // pop page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(), // replace popped page to call init again
          ),
        );
        ad.dispose(); // dispose ad
      },

      // if ad fails to show
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        Navigator.pop(context); // pop page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(), // replace popped page to call init again
          ),
        );
        print('$ad onAdFailedToShowFullScreenContent: $error'); // print error
        ad.dispose(); // dispose ad
      },
    );

    myInterstitial.show(); // show ad
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _showInterstitialAd();
        Navigator.pop(context); // pops page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(), // replace popped page to call init again
          ),
        );
      },
      child: Scaffold(
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
              Navigator.pop(context); // pops page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage(), // replace popped page to call init again
                ),
              );
            },
          ),
          title: Flexible(
            child: Text(
              '${widget.countryName} Covid Updates',
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.blueGrey[600],
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              overflow: TextOverflow.ellipsis,
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
                    widget.flag,
                    height: 100,
                    width: 100,
                  ),
                  Flexible(
                    child: Text(
                      '${widget.countryName}',
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
                    'Last Updated on\n${getFormattedDate(widget.updated, 'hh:mm a')}',
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
                    title: 'Total\nCases',
                    data: widget.cases,
                    color: Colors.brown[600],
                  ),
                  CovidInfoCard(
                    title: 'Total\nRecovered',
                    data: widget.recovered,
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
                    title: 'Cases\nToday',
                    data: widget.casesToday,
                    color: Colors.black,
                  ),
                  CovidInfoCard(
                    title: 'Recovered\nToday',
                    data: widget.recoveredToday,
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
                    title: 'Total\nDeaths',
                    data: widget.deaths,
                    color: Colors.red[500],
                  ),
                  CovidInfoCard(
                    title: 'Deaths\nToday',
                    data: widget.todayDeaths,
                    color: Colors.red[900],
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}