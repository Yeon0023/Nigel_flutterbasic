import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nigel_flutterbasic/view/Login_view.dart';
import 'package:nigel_flutterbasic/view/Register_view.dart';
import 'package:nigel_flutterbasic/view/Verify_email_view.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  //This is to connect device app to firebase server.
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
      routes: {
       '/login/': (context) => const LoginView(),
       '/register/' : (context) => const RegisterView(), 
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
          final user = FirebaseAuth.instance.currentUser;
          if(user!=null){
            if(user.emailVerified){
              print('Email is Verified');
              }
              else {
                return const VerifyEmailView();
              } 
          } else {
              return const LoginView();
            }
          return const Text('Done');
          default: 
            return const CircularProgressIndicator();
        }
      },
    );
  }
}











//***Old code that was removed***

// final user = FirebaseAuth.instance.currentUser;
// print(user);
// if (user?.emailVerified ?? false){
//     return const Text('Done');
//   } else {
//     return const VerifyEmailView();
//   }

// This is what called setting up an Anonymous Route 
// WidgetsBinding.instance.addPostFrameCallback((_) {
//   Navigator.pushReplacement(
//     context, MaterialPageRoute(
//       builder: (_) => const VerifyEmailView()
//     ),
//   );
// });
// Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (context) => const VerifyEmailView(),
//   ),
// )

// Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home')),
//       body: FutureBuilder(
//         future: Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform,
//         ),
//           builder: (context, snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.done:
//                 return const LoginView();
//               default: 
//                 return const Text("Loading...");
//             }
//           },
//         ),
//       );
//     }


//Switch for connecting device to server
// switch (snapshot.connectionState) {
//   case ConnectionState.done:
//     return const LoginView();
//   default: 
//     return const CircularProgressIndicator();
// }