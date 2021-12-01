// // import 'dart:convert';
// // import 'package:flutter_auth/constants.dart';
// // import 'post_page.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:async';
// // // import 'feed_model.dart';

// // Future<Feed> fetchFeed() async {
// //   final response =
// //       await http.get(Uri.parse('https://retoolapi.dev/UAoyEV/feed/'));

// //   if (response.statusCode == 200) {
// //     // If the server did return a 200 OK response,
// //     // then parse the JSON.

// //     return Feed.fromJson(jsonDecode(response.body));
// //   } else {
// //     // If the server did not return a 200 OK response,
// //     // then throw an exception.
// //     throw Exception('Failed to load album');
// //   }
// // }

// // class Feed {
// //   Feed({
// //     required this.id,
// //     required this.username,
// //     required this.desc,
// //   });

// //   int id;
// //   String username;
// //   String desc;

// //   factory Feed.fromJson(Map<String, dynamic> json) {
// //     return Feed(
// //       id: json['id'],
// //       username: json['username'],
// //       desc: json['desc'],
// //     );
// //   }
// // }

// // class Home extends StatefulWidget {
// //   @override
// //   _HomePage createState() => _HomePage();
// // }

// // class _HomePage extends State<Home> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           "Home",
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: Icon(
//           Icons.account_circle,
//           color: Colors.grey,
//           size: 40.0,
//         ),
//       ),
//       body: Center(
//         child: FutureBuilder<Feed>(
//           future: futureFeed,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListTile(
//                 title: Text(snapshot.data!.username),
//                 subtitle: Text(snapshot.data!.desc),
//               );
//             } else if (snapshot.hasError) {
//               return Text('${snapshot.error}');
//             }

//             // By default, show a loading spinner.
//             return const CircularProgressIndicator();
//           },
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, position) {
//           return Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Icon(
//                         Icons.account_circle,
//                         size: 60.0,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.only(top: 5.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Container(
//                                       child: RichText(
//                                     text: TextSpan(children: [
//                                       TextSpan(
//                                         text: "John Doe",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 18.0,
//                                             color: Colors.black),
//                                       ),
//                                     ]),
//                                     overflow: TextOverflow.ellipsis,
//                                   )),
//                                   flex: 5,
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(right: 4.0),
//                                     child: Icon(
//                                       Icons.share,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   // flex: 1,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 10.0),
//                             child: Text(
//                               'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In hac habitasse platea dictumst. Vivamus auctor magna ut arcu mattis, ut volutpat risus cursus. In eget finibus dui. Duis vitae molestie odio.',
//                               style: TextStyle(fontSize: 16.0),
//                             ),
//                           ),
//                           Image.network(
//                               'https://img.purch.com/rc/1680x1050/aHR0cDovL3d3dy5zcGFjZS5jb20vaW1hZ2VzL2kvMDAwLzA0My8zMjgvb3JpZ2luYWwvYXJvdW5kLWEtc3Rhci1zeXN0ZW0tMTkyMC5qcGc='),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Divider(),
//             ],
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Post()),
//           );
//         },
//         backgroundColor: kPrimaryColor,
//         child: Icon(
//           Icons.add,
//         ),
//       ),
//     );
//   }
// }
