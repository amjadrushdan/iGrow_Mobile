import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/workshop/book_upcoming.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/filterscreen.dart';

import 'book_history.dart';

class NavBooked extends StatefulWidget {
  const NavBooked({Key? key}) : super(key: key);

  @override
  _NavBookedState createState() => _NavBookedState();
}

class _NavBookedState extends State<NavBooked> {
  String filterText = "";
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Booked Workshop'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Upcoming',
              ),
              Tab(
                text: 'History',
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FilterScreen();
                      },
                    ),
                  );
                  setState(
                    () {
                      filterText = "$result";
                    },
                  );
                  print(result);
                },
                child: Icon(
                  Icons.filter_alt_sharp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(children: [
          ListPage(FilterText: filterText),
          HistoryBook(FilterText: filterText),
        ]),
      ));
}
