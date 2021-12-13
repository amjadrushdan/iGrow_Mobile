// import 'package:flutter/material.dart';
// import 'package:flutter_auth/Screens/home/feed_model.dart';
// import 'feed_service.dart';
// import 'feed_model.dart';

// class Home extends StatefulWidget {
//   Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late Future<List<Feed>> futureFeed;
//   @override
//   void initState() {
//     super.initState();
//     futureFeed = fetchFeed();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: FutureBuilder<List<Feed>>(
//               future: futureFeed,
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasData) {
//                   List<Feed>? feed = snapshot.data;
//                   return ListView.builder(
//                       itemCount: feed!.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         // return Container(
//                         //   height: 75,
//                         //   color: Colors.white,
//                         //   child: Center(
//                         //     child: Text(feed[index].creatorId),
//                         //   ),
//                         // );
//                         return Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Icon(
//                                       Icons.account_circle,
//                                       size: 60.0,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: <Widget>[
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 5.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: <Widget>[
//                                               Expanded(
//                                                 child: Container(
//                                                     child: RichText(
//                                                   text: TextSpan(children: [
//                                                     TextSpan(
//                                                       text:
//                                                           feed[index].creatorId,
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           fontSize: 18.0,
//                                                           color: Colors.black),
//                                                     ),
//                                                   ]),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 )),
//                                                 flex: 5,
//                                               ),
//                                               Expanded(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           right: 4.0),
//                                                   child: Icon(
//                                                     Icons.share,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                                 // flex: 1,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 10.0),
//                                           child: Text(
//                                             feed[index].title,
//                                             style: TextStyle(fontSize: 16.0),
//                                           ),
//                                         ),
//                                         Image.network(
//                                             'https://img.purch.com/rc/1680x1050/aHR0cDovL3d3dy5zcGFjZS5jb20vaW1hZ2VzL2kvMDAwLzA0My8zMjgvb3JpZ2luYWwvYXJvdW5kLWEtc3Rhci1zeXN0ZW0tMTkyMC5qcGc='),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Divider(),
//                           ],
//                         );
//                       });
//                 } else {
//                   return Text("${snapshot.error}");
//                 }
//               })),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/feed_model.dart';
import 'package:flutter_auth/Screens/home/post_page.dart';
import '../../constants.dart';
import 'feed_service.dart';
import 'feed_model.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Feed>> futureFeed;
  @override
  void initState() {
    super.initState();
    futureFeed = fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.account_circle,
          color: Colors.grey,
          size: 40.0,
        ),
      ),
      body: Center(
          child: FutureBuilder<List<Feed>>(
              future: futureFeed,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Feed>? feed = snapshot.data;
                  return ListView.builder(
                      itemCount: feed!.length,
                      itemBuilder: (BuildContext context, int index) {
                        // return Container(
                        //   height: 75,
                        //   color: Colors.white,
                        //   child: Center(
                        //     child: Text(feed[index].creatorId),
                        //   ),
                        // );
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.account_circle,
                                      size: 60.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                    child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text:
                                                          feed[index].creatorId,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18.0,
                                                          color: Colors.black),
                                                    ),
                                                  ]),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                                flex: 5,
                                              ),
                                              // Expanded(
                                              //   child: Padding(
                                              //     padding:
                                              //         const EdgeInsets.only(
                                              //             right: 4.0),
                                              //     child: Icon(
                                              //       Icons.share,
                                              //       color: Colors.grey,
                                              //     ),
                                              //   ),
                                              //   // flex: 1,
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Text(
                                            feed[index].title,
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Text(
                                            feed[index].message,
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                        Image.network(
                                            'https://img.purch.com/rc/1680x1050/aHR0cDovL3d3dy5zcGFjZS5jb20vaW1hZ2VzL2kvMDAwLzA0My8zMjgvb3JpZ2luYWwvYXJvdW5kLWEtc3Rhci1zeXN0ZW0tMTkyMC5qcGc='),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.7,
                            ),
                          ],
                        );
                      });
                } else {
                  return Text("${snapshot.error}");
                  // return const CircularProgressIndicator();
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Post()),
          );
        },
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
