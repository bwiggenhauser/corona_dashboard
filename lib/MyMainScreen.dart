import 'dart:convert';
import 'dart:developer';

import 'package:corona_dashboard/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MyMainScreen extends StatefulWidget {
  @override
  _MyMainScreenState createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  String currentCountry = 'Argentina';
  String dropdownvalue = 'Argentina';
  int _casesLastWeek = -1;
  int _casesThisWeek = -1;
  int _deathsLastWeek = -1;
  int _deathsThisWeek = -1;
  int _casesTotal = -1;
  int _deathsTotal = -1;
  double _casesPer100k = -1;
  double _deathsPer100k = -1;

  MaterialColor _casesTrendColor;

  IconData _casesTrendIcon;

  MaterialColor _deathsTrendColor;

  IconData _deathsTrendIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color1, color2])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              'Data for $currentCountry',
              style: GoogleFonts.nunito(fontSize: 30.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          'CASES',
                          style: GoogleFonts.nunito(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'NEW',
                              style: GoogleFonts.nunito(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'CASES',
                              style: GoogleFonts.nunito(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Last Week',
                              style: GoogleFonts.nunito(fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _casesLastWeek.toString(),
                                style: GoogleFonts.nunito(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'This Week',
                              style: GoogleFonts.nunito(fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _casesThisWeek.toString(),
                                style: GoogleFonts.nunito(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _casesTrendColor,
                            borderRadius: BorderRadius.circular(999.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              _casesTrendIcon,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'TOTAL',
                              style: GoogleFonts.nunito(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'CASES',
                              style: GoogleFonts.nunito(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Total Cases',
                              style: GoogleFonts.nunito(fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _casesTotal.toString(),
                                style: GoogleFonts.nunito(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Per 100k',
                              style: GoogleFonts.nunito(fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _casesPer100k.toString(),
                                style: GoogleFonts.nunito(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          'DEATHS',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              letterSpacing: 1.5),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'NEW',
                              style: GoogleFonts.nunito(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'DEATHS',
                              style: GoogleFonts.nunito(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Last Week',
                              style: GoogleFonts.nunito(fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _deathsLastWeek.toString(),
                                style: GoogleFonts.nunito(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'This Week',
                              style: GoogleFonts.nunito(fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _deathsThisWeek.toString(),
                                style: GoogleFonts.nunito(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _deathsTrendColor,
                            borderRadius: BorderRadius.circular(999.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              _deathsTrendIcon,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              'TOTAL',
                              style: GoogleFonts.nunito(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'DEATHS',
                              style: GoogleFonts.nunito(
                                  fontSize: 17.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Total Deaths',
                              style: GoogleFonts.nunito(fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _deathsTotal.toString(),
                                style: GoogleFonts.nunito(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Per 100k',
                              style: GoogleFonts.nunito(fontSize: 15.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _deathsPer100k.toString(),
                                style: GoogleFonts.nunito(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton<String>(
                      value: dropdownvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 8,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownvalue = newValue;
                          currentCountry = dropdownvalue;
                        });
                        fetchData();
                      },
                      items: <String>[
                        "Afghanistan",
                        "Albania",
                        "Algeria",
                        "Andorra",
                        "Angola",
                        "Argentina",
                        "Armenia",
                        "Australia",
                        "Austria",
                        "Azerbaijan",
                        "Bahamas",
                        "Bahrain",
                        "Bangladesh",
                        "Belarus",
                        "Belgium",
                        "Bolivia",
                        "Bosnia-and-Herzegovina",
                        "Botswana",
                        "Brazil",
                        "Bulgaria",
                        "Burkina-Faso",
                        "Canada",
                        "Chile",
                        "China",
                        "Colombia",
                        "Congo",
                        "Costa-Rica",
                        "Croatia",
                        "Czechia",
                        "Denmark",
                        "DRC",
                        "Ecuador",
                        "Egypt",
                        "El-Salvador",
                        "Estonia",
                        "Finland",
                        "France",
                        "Georgia",
                        "Germany",
                        "Greece",
                        "Honduras",
                        "Hungary",
                        "Iceland",
                        "India",
                        "Indonesia",
                        "Iran",
                        "Iraq",
                        "Ireland",
                        "Israel",
                        "Italy",
                        "Ivory-Coast",
                        "Jamaica",
                        "Japan",
                        "Jordan",
                        "Kazakhstan",
                        "Kenya",
                        "Kuwait",
                        "Kyrgyzstan",
                        "Lebanon",
                        "Liechtenstein",
                        "Lithuania",
                        "Luxembourg",
                        "Malaysia",
                        "Mexico",
                        "Monaco",
                        "Mongolia",
                        "Morocco",
                        "Namibia",
                        "Nepal",
                        "Netherlands",
                        "New-Zealand",
                        "Nicaragua",
                        "Niger",
                        "Nigeria",
                        "Norway",
                        "Pakistan",
                        "Palestine",
                        "Panama",
                        "Paraguay",
                        "Peru",
                        "Philippines",
                        "Poland",
                        "Portugal",
                        "Puerto-Rico",
                        "Qatar",
                        "Romania",
                        "Russia",
                        "S-Korea",
                        "Saudi-Arabia",
                        "Senegal",
                        "Serbia",
                        "Singapore",
                        "Slovakia",
                        "Slovenia",
                        "Somalia",
                        "South-Africa",
                        "South-Sudan",
                        "Spain",
                        "Sudan",
                        "Sweden",
                        "Switzerland",
                        "Syria",
                        "Taiwan",
                        "Tajikistan",
                        "Thailand",
                        "Tunisia",
                        "Turkey",
                        "UAE",
                        "UK",
                        "Ukraine",
                        "Uruguay",
                        "USA",
                        "Uzbekistan",
                        "Vatican-City",
                        "Venezuela",
                        "Vietnam",
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                style: GoogleFonts.nunito(fontSize: 17.0),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchData() async {
    var country = currentCountry;
    var response =
        await http.get('https://covid-api-wigge.herokuapp.com/$country');
    var res = response.body;
    Map<String, dynamic> data = jsonDecode(res);
    setState(() {
      _casesThisWeek = data['casesThisWeek'];
      _casesLastWeek = data['casesLastWeek'];
      _deathsThisWeek = data['deathsThisWeek'];
      _deathsLastWeek = data['deathsLastWeek'];
      _casesTotal = data['casesTotal'];
      _deathsTotal = data['deathsTotal'];
      _casesPer100k = data['casesPer100k'];
      _deathsPer100k = data['deathsPer100k'];
    });

    var caTh = _casesThisWeek;
    var caLa = _casesLastWeek;
    var deTh = _deathsThisWeek;
    var deLa = _deathsLastWeek;

    // Setting the color and the trend arrow icon
    if (caTh / caLa < 1.1 && caTh / caLa > 0.9) {
      _casesTrendColor = colorStay;
      _casesTrendIcon = arrowStay;
    } else if (caTh > caLa) {
      _casesTrendColor = colorUp;
      _casesTrendIcon = arrowUp;
    } else {
      _casesTrendColor = colorDown;
      _casesTrendIcon = arrowDown;
    }
    if (deTh / deLa < 1.1 && deTh / deLa > 0.9) {
      _deathsTrendColor = colorStay;
      _deathsTrendIcon = arrowStay;
    } else if (deTh > deLa) {
      _deathsTrendColor = colorUp;
      _deathsTrendIcon = arrowUp;
    } else {
      _deathsTrendColor = colorDown;
      _deathsTrendIcon = arrowDown;
    }
  }
}
