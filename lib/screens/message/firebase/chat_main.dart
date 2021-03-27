// import 'package:flutter/material.dart';
//
// class FlashChat extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: Firebase.initializeApp(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return CircularProgressIndicator();
//           }
//
//           return MaterialApp(
//             theme: ThemeData.dark().copyWith(
//               textTheme: TextTheme(
//                 body1: TextStyle(color: Colors.black54),
//               ),
//             ),
//             initialRoute: WelcomeScreen.id,
//             routes: {
//               WelcomeScreen.id: (context) => WelcomeScreen(),
//               LoginScreen.id: (context) => LoginScreen(),
//               RegistrationScreen.id: (context) => RegistrationScreen(),
//               ChatScreen.id: (context) => ChatScreen()
//
//
//             },
//             // home: WelcomeScreen(),
//           );
//         }
//     );
//
//   }
//   Future<DocumentSnapshot> getData() async {
//     await Firebase.initializeApp();
//     return await FirebaseFirestore.instance
//         .collection("users")
//         .doc("docID")
//         .get();
//   }
// }