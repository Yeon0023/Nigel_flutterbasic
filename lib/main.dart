import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nigel_flutterbasic/constats/routes.dart';
import 'package:nigel_flutterbasic/view/login_view.dart';
import 'package:nigel_flutterbasic/view/register_view.dart';
import 'package:nigel_flutterbasic/view/verify_email_view.dart';
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
        // '/login/': (context) => const LoginView(),
        // '/register/': (context) => const RegisterView(),
        // '/note/': (context) => const NoteView(),
        // Use not Hard coding referces below
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        noteRoute: (context) => const NoteView(),
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
            if (user != null) {
              if (user.emailVerified) {
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

enum MenuAction { logout }

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              // devtools.log(value.toString());
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  // devtools.log(shouldLogout.toString());
                  // break;
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    //ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      //'/login/',
                      loginRoute,
                      (_) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text('Logout')),
              ];
            },
          )
        ],
      ),
      body: const Text('Hello World!'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to Logout?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log out')),
        ],
      );
    },
  ).then((value) => value ?? false);
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
