import 'package:google_fonts/google_fonts.dart';
import 'utils.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
            // => AFFECTED
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
                      "Affected",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Text(
                      "N/A",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // => DEATH
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
                      "Death",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Text(
                      "N/A",
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
                      "N/A",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // => ACTIVE
            Positioned(
              top: 347,
              child: Container(
                height: 85,
                width: 97.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[400],
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Active",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Text(
                      "N/A",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // => SERIOUS
            Positioned(
              top: 347,
              left: 240,
              child: Container(
                height: 85,
                width: 97.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple[400],
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Serious",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Text(
                      "N/A",
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
                    // Added Search-IconButton at the top right corner
                    Container(
                      margin: EdgeInsets.only(right: 14.4, top: 14.4),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Utils.printDebug("PRESSED SEARCH BUTTON");
                        },
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
                // Added ToggleButton MYCOUNTRY/GLOBAL
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
                        print('switched to: $index');
                      }),
                ),
                //Added ToggleButton TOTAL/TODAY/YESTERDAY
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
                        print('switched to: $index');
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
