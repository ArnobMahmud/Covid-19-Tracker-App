class CovidData {
  int updated;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int todayRecovered;
  int active;
  int critical;
  int casesPerOneMillion;
  double deathsPerOneMillion;
  int tests;
  int testsPerOneMillion;
  int population;
  int oneCasePerPeople;
  int oneDeathPerPeople;
  int oneTestPerPeople;
  double activePerOneMillion;
  double recoveredPerOneMillion;
  double criticalPerOneMillion;
  CovidData({
    this.updated,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.population,
    this.oneCasePerPeople,
    this.oneDeathPerPeople,
    this.oneTestPerPeople,
    this.activePerOneMillion,
    this.recoveredPerOneMillion,
    this.criticalPerOneMillion,
  });

  factory CovidData.fromJson(Map<String, dynamic> json) {
    return CovidData(
      updated: json['updated'],
      cases: json['cases'],
      todayCases: json['todaycases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      todayRecovered: json['todayRecovered'],
      active: json['active'],
      critical: json['critical'],
      criticalPerOneMillion: json['criticalPerOneMillion'],
      deathsPerOneMillion: json['deathsPerOneMillion'],
      tests: json['tests'],
      testsPerOneMillion: json['testsPerOneMillion'],
      population: json['population'],
      oneCasePerPeople: json['oneCasePerPeople'],
      oneDeathPerPeople: json['oneDeathPerPeople'],
      oneTestPerPeople: json['oneTestPerPeople'],
      activePerOneMillion: json['activePerOneMillion'],
      recoveredPerOneMillion: json['recoveredPerOneMillion'],
      casesPerOneMillion: json['casesPerOneMillion'],
    );
  }
}
