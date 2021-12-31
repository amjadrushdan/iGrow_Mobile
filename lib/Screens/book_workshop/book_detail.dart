import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';

class BookingDetail extends StatefulWidget{
  final DocumentSnapshot post;
  BookingDetail({required this.post});

  @override
  BookingInfo createState() => BookingInfo();
}

class BookingInfo extends State<BookingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post["programmename"]),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: [ListTile(
          title: Text("Speaker"),
          subtitle: Text(widget.post["speaker"]),
        ),
        ListTile(
          title: Text("Person in Charge"),
          subtitle: Text(widget.post["PIC"]),
        ),
        ListTile(
          title: Text("Date"),
          subtitle: Text(widget.post["date"]),
        ),
        ListTile(
          title: Text("Time"),
          subtitle: Text(widget.post["starttime"] + " - " + widget.post["endtime"]),
        ),
        ListTile(
          title: Text("Description"),
          subtitle: Text(widget.post["description"]),
        ),
       const SizedBox(height: 280,),
       Container(
        height: 45,
        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: ElevatedButton(
        style: raisedButtonStyle,
        child: Text('Apply'),
        onPressed: (){FirebaseFirestore.instance.collection('workshop').doc().set({
        'programmename': widget.post["programmename"],
        'speaker': widget.post["speaker"],
        'PIC': widget.post["PIC"],
        'date': widget.post["date"],
        'starttime': widget.post["starttime"],
        'endtime': widget.post["endtime"],
        'description': widget.post["description"],

      });

                          }
                          )),
        ],
        
      ),

      
    );
    
  }

}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: kPrimaryColor,
  minimumSize: const Size(40, 40),
  padding: const EdgeInsets.symmetric(horizontal: 40),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
);
//   final List<String> items = <String>[
//     'Select', 'Session 1: 24/11/2021 10:00 AM - 12:00 PM', 
//     'Session 2: 2/12/2021 2:00 PM - 5:00 PM',
//     'Session 3: 14/1/2022 2:00 PM - 5:00 PM',
//     'Session 4: 30/1/2022 10:00 AM - 1:00 PM',
    
//   ];
//   String dropdownValue = 'Select';
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: Column(
//         children: [
//           const SizedBox(height: 24),
//           Container(
//             padding: EdgeInsets.symmetric(
//               vertical: size.height*0.024,
//             ),
//             alignment: Alignment.center,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: kPrimaryColor,
//             ),
//             child: Text('Workshop 1', style: TextStyle(
//               color: Colors.white, fontSize: size.width*0.04,
//             ))
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.width*0.05,
//                 vertical: size.height*0.03,
//               ),
//               margin: const EdgeInsets.only(top: 20),
//               width:double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(13),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Name: Workshop 1', style: TextStyle(fontSize: size.width*0.044, 
//                   fontWeight: FontWeight.bold),),
//                   SizedBox(height: size.height*0.02),
//                   Row(children: [
                    
//                     Text('Description: Workshop 1 about type of plants and soil tutorial', style: TextStyle(
//                       fontSize: size.width*0.03,
//                     ),),
//                   ],),
//                   SizedBox(height: size.height*0.02,),
//                 ],)
//               ),
//               SizedBox(height: 27,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Select session', style: TextStyle(fontWeight: FontWeight.bold),)
//                 ],
//               ),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 4,
//                 ),
//                 margin: const EdgeInsets.only(top: 10),
//                 width: double.infinity,
//                 decoration: BoxDecoration(color: Colors.white,
//                 borderRadius: BorderRadius.circular(15)),
//                   child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     onChanged: (String? newValue){
//                       setState(() {
//                         dropdownValue = newValue!;
//                       }
//                       );
//                     },
//                     value: dropdownValue,
//                     items: items.map<DropdownMenuItem<String>>(
//                       (String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                           );
//                       },
//                     ).toList(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 380,),
//                 RoundedButton(
                
//                 text: "Apply",
                
//                 press: () {
                
//                   }
//                 ),
//         ],)
//     );

    
  // }
  // void showAlertDialog(BuildContext context) => showDialog(
  //   builder: (context) => AlertDialog(
  //     title: Text('Testing'),
  //     content: Text('Trying'),
  //     actions: [
  //       OutlineButton(
  //         onPressed:() => Navigator.of(context).pop(),
  //         child: Text('Confirm'),
  //          )
  //     ],
  //   ), context: context
  //   );


//   void setState(Null Function() param0) {}

// }
