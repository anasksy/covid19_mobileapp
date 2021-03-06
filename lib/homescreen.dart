import 'package:google_fonts/google_fonts.dart';
import 'package:number_display/number_display.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'api/api.dart';
import 'noconnection.dart';
import 'utils.dart';

enum ToggleSwitchStateCountry { global, mycountry }
enum ToggleSwitchStateTimeSpan { total, today, yesterday }

final display = createDisplay(
  length: 5,
  decimal: 0,
);

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

/* TODO (kai): 
 * - active and serious widget thingy wegmachen
 * - refreshen 
 * - location permissions abfragen
 * - graph
 */

class _HomescreenState extends State<Homescreen> {
  // variables:

  dynamic toggle_switch_state_country = ToggleSwitchStateCountry.mycountry;
  dynamic toggle_switch_state_timespan = ToggleSwitchStateTimeSpan.total;
  String confirmed = "N/A";
  String deaths = "N/A";
  String recovered = "N/A";

  void refreshData() {
    switch (toggle_switch_state_timespan) {
      case ToggleSwitchStateTimeSpan.total:
        switch (toggle_switch_state_country) {
          case ToggleSwitchStateCountry.global:
            setState(
                () => confirmed = display(API.getConfirmedCasesGlobalTotal()));
            setState(() => deaths = display(API.getDeathsGlobalTotal()));
            setState(() => recovered = display(API.getRecoveredGlobalTotal()));
            break;
          case ToggleSwitchStateCountry.mycountry:
            // TODO: check for country and get country specific data
            setState(() => confirmed = "N/A");
            setState(() => deaths = "N/A");
            setState(() => recovered = "N/A");
            break;
        }
        break;
      case ToggleSwitchStateTimeSpan.today:
        switch (toggle_switch_state_country) {
          case ToggleSwitchStateCountry.global:
            /* TODO
             *
             *  FIX THIS SHIT IT DISPLAYS 0 WDNIAWJDWAIJDWI
             * 
             * 
             * 
             */

            DateTime date = DateTime.now();
            // ik its bit confusing but i use the real yesterday as today because the api only has data for past days..
            DateTime today = new DateTime(date.year, date.month, date.day - 1);
            DateTime yesterday =
                new DateTime(date.year, date.month, date.day - 2);

            int confirmedtoday =
                API.getConfirmedCasesGlobalByDate(API.formatDateTime(today));
            int confirmedyesterday = API
                .getConfirmedCasesGlobalByDate(API.formatDateTime(yesterday));
            int deathstoday =
                API.getDeathsGlobalByDate(API.formatDateTime(today));
            int deathsyesterday =
                API.getDeathsGlobalByDate(API.formatDateTime(yesterday));
            int recoveredtoday =
                API.getRecoveredGlobalByDate(API.formatDateTime(today));
            int recoveredyesterday =
                API.getRecoveredGlobalByDate(API.formatDateTime(yesterday));

            setState(
                () => confirmed = display(confirmedtoday - confirmedyesterday));
            setState(() => deaths = display(deathstoday - deathsyesterday));
            setState(
                () => recovered = display(recoveredtoday - recoveredyesterday));
            break;
          case ToggleSwitchStateCountry.mycountry:
            // TODO: check for country and get country specific data
            setState(() => confirmed = "N/A");
            setState(() => deaths = "N/A");
            setState(() => recovered = "N/A");
            break;
        }
        break;
      case ToggleSwitchStateTimeSpan.yesterday:
        switch (toggle_switch_state_country) {
          case ToggleSwitchStateCountry.global:
            /* TODO
             *
             * 
             * 
             * 
             * 
             */
            break;
          case ToggleSwitchStateCountry.mycountry:
            // TODO: check for country and get country specific data
            setState(() => confirmed = "N/A");
            setState(() => deaths = "N/A");
            setState(() => recovered = "N/A");
            break;
        }
        break;
    }
    Utils.printDebug("Confimred = " + confirmed);
    Utils.printDebug("Deaths = " + deaths);
    Utils.printDebug("Recovered = " + recovered);
  }

  void _refreshAPI(context) async {
    if (await API.loadData() == false) {
      // no internet or api couldnt get initialized
      Utils.printDebug("API INIT ERROR");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => noConnection()),
      );
    } else {
      Utils.printDebug("API INIT SUCCESSFUL");
      refreshData();
      // refresh was successful
      // show on screen that succesful
    }
  }

  _refreshAction(context) {
    setState(() {
      _refreshAPI(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // no need currently ==> var size = MediaQuery.of(context).size;
    // old code 1 ==> List<bool> _selections = List.generate(2, (_) => false);
    // old code 2 ==> List<bool> _selections2 = List.generate(3, (_) => false);
    return Scaffold(
      backgroundColor: Colors.purple[800],
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //Added 2 Containers
            Positioned(
              right: 186,
              top: 250,
              child: Container(
                height: 85,
                width: 153.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange[400],
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Confirmed Cases",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Text(
                      confirmed,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // => DEATHS
            Positioned(
              left: 186,
              top: 250,
              child: Container(
                height: 85,
                width: 153.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red[400],
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Deaths",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Text(
                      deaths,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // => RECOVERED
            Positioned(
              top: 347,
              right: 240,
              child: Container(
                height: 85,
                width: 97.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[400],
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Recovered",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Text(
                      recovered,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Added white container with rounded corners
            Container(
              margin: EdgeInsets.only(top: 470),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
            ),

            // Added "Daily New Cases" Text
            // ==> it's in the white container at the bottom
            Container(
              child: Text(
                "Daily New Cases",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              margin: EdgeInsets.only(top: 510, left: 24),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Added Menu-IconButton at the top left corner
                    Container(
                      margin: EdgeInsets.only(left: 14.4, top: 14.4),
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          Utils.printDebug("PRESSED MENU BUTTON");
                        },
                        color: Colors.white,
                        highlightColor: Colors.white70,
                        iconSize: 35.0,
                      ),
                    ),
                    // Added REFRESH-IconButton at the top right corner
                    Container(
                      margin: EdgeInsets.only(right: 14.4, top: 14.4),
                      child: IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          _refreshAction(context);
                          Utils.printDebug("PRESSED REFRESH BUTTON");
                        },
                        tooltip: "Press to refresh",
                        color: Colors.white,
                        highlightColor: Colors.white70,
                        iconSize: 35.0,
                      ),
                    ),
                  ],
                ),
                // Added "Statistics" Text
                // ==> it's under the Menu-IconButton at the top left corner
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 24, top: 30),
                  child: Text(
                    "Statistics",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 23.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Added ToggleSwitch MYCOUNTRY/GLOBAL
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: ToggleSwitch(
                      minWidth: 150.0,
                      cornerRadius: 20,
                      activeBgColor: Colors.white,
                      activeTextColor: Colors.black87,
                      inactiveBgColor: Colors.white54,
                      inactiveTextColor: Colors.white70,
                      labels: ['My Country', 'Global'],
                      onToggle: (index) {
                        // assign value to variables on switch
                        switch (index) {
                          case 0:
                            toggle_switch_state_country =
                                ToggleSwitchStateCountry.mycountry;
                            break;
                          case 1:
                            toggle_switch_state_country =
                                ToggleSwitchStateCountry.global;
                            break;
                        }

                        refreshData();

                        Utils.printDebug(
                            'COUNTRY TOGGLESWITCH = switched to: $toggle_switch_state_country');
                      }),
                ),
                //Added ToggleSwitch TOTAL/TODAY/YESTERDAY
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ToggleSwitch(
                      minWidth: 75.0,
                      activeBgColor: Colors.purple[800],
                      activeTextColor: Colors.white,
                      inactiveBgColor: Colors.purple[800],
                      inactiveTextColor: Colors.white70,
                      labels: ['Total', 'Today', 'Yesterday'],
                      onToggle: (index) {
                        // assign value to variables on switch
                        switch (index) {
                          case 0:
                            toggle_switch_state_timespan =
                                ToggleSwitchStateTimeSpan.total;
                            break;
                          case 1:
                            toggle_switch_state_timespan =
                                ToggleSwitchStateTimeSpan.today;
                            break;
                          case 2:
                            toggle_switch_state_timespan =
                                ToggleSwitchStateTimeSpan.yesterday;
                            break;
                        }

                        refreshData();

                        Utils.printDebug(
                            'TIMESPAN TOGGLESWITCH = switched to: $toggle_switch_state_timespan');
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
