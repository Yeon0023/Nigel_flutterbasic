import 'package:flutter/material.dart';
import 'package:nigel_flutterbasic/constats/routes.dart';
import 'package:nigel_flutterbasic/service/auth/auth_service.dart';
import 'package:nigel_flutterbasic/view/login_view.dart';
import 'package:nigel_flutterbasic/view/note_view.dart';
import 'package:nigel_flutterbasic/view/register_view.dart';
import 'package:nigel_flutterbasic/view/verify_email_view.dart';

void main() {
  //This is to connect device app to firebase server.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
      routes: {
        // '/login/': (context) => const LoginView(),
        // '/register/': (context) => const RegisterView(),
        // '/note/': (context) => const NoteView(),
        // Use not Hard coding referces below
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        noteRoute: (context) => const NoteView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NoteView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
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
//   }
