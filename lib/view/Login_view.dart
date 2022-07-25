//import '../firebase_options.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:nigel_flutterbasic/view/Login_view.dart';
//import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nigel_flutterbasic/constats/routes.dart';
import 'package:nigel_flutterbasic/view/verify_email_view.dart';
import '../Utilities/Show_error_dialog.dart'; //This is to replace print()

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Email Here",
                  ),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Password Here",
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      final user = FirebaseAuth.instance.currentUser;
                      if (user?.emailVerified ?? false) {
                        // If user email is verified
                        //ignore: use_build_context_synchronously
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          noteRoute,
                          (route) => false,
                        );
                      } else {
                        // If user email is NOT verified
                        ////ignore: use_build_context_synchronously
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyEmailRoute,
                          (route) => false,
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      //print(e.code);
                      if (e.code == 'user-not-found') {
                        await showErrorDialog(
                          context,
                          'User not found',
                        );
                      } else if (e.code == 'wrong-password') {
                        await showErrorDialog(
                          context,
                          'Wrong Password',
                        );
                      } else {
                        await showErrorDialog(
                          context,
                          'Error:${e.code}',
                        );
                      }
                    } catch (e) {
                      await showErrorDialog(
                        context,
                        e.toString(),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  },
                  child: const Text('Not registered yet? Register here!'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ***Old code This was remote***
// After 26.07.22
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('login'),
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _email,
//                   enableSuggestions: false,
//                   autocorrect: false,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     hintText: "Enter Your Email Here",
//                   ),
//                 ),
//                 TextField(
//                   controller: _password,
//                   obscureText: true,
//                   enableSuggestions: false,
//                   autocorrect: false,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     hintText: "Enter Your Password Here",
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () async {
//                     final email = _email.text;
//                     final password = _password.text;
//                     //Handling Exception when Login fail or no user registered
//                     try {
//                       await FirebaseAuth.instance.signInWithEmailAndPassword(
//                         email: email,
//                         password: password,
//                       );
//                       //devtools.log(userCredential.toString());
//                       //ignore: use_build_context_synchronously
//                       Navigator.of(context).pushNamedAndRemoveUntil(
//                         //'/note/',
//                         noteRoute,
//                         (route) => false,
//                       );
//                     } on FirebaseAuthException catch (e) {
//                       //print(e.code);
//                       if (e.code == 'user-not-found') {
//                         await showErrorDialog(
//                           context,
//                           'User not found',
//                         );
//                         //devtools.log('User Not Found!');
//                         //print('user-not-found');
//                         // catch (e) {  //(e) catch all error
//                         //   print('Login Failed!');
//                         //   print(e); //print the error itself
//                         //   print(e.runtimeType); //print error type
//                       } else if (e.code == 'wrong-password') {
//                         await showErrorDialog(
//                           context,
//                           'Wrong Password',
//                         );
//                         //devtools.log('Wrong Password!');
//                         // print('Something else happen');
//                         // print(e.code);
//                       } else {
//                         await showErrorDialog(
//                           context,
//                           'Error:${e.code}',
//                         );
//                       }
//                     } catch (e) {
//                       await showErrorDialog(
//                         context,
//                         e.toString(),
//                       );
//                     }
//                   },
//                   child: const Text("Login"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pushNamedAndRemoveUntil(
//                       //'/register/',s
//                       registerRoute,
//                       (route) => false,
//                     );
//                   },
//                   child: const Text('Not registered yet? Register here!'),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//Before 26.07.22
// return Scaffold(
//   appBar: AppBar(title: const Text("Login")),
//   body: FutureBuilder(
//     future: Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     ),
//     builder: (context, snapshot) {
//       switch (snapshot.connectionState) {
//         case ConnectionState.done:
//           return Column(
//             children: [
//               TextField(
//                 controller: _email,
//                 enableSuggestions: false,
//                 autocorrect: false,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: const InputDecoration(
//                   hintText: "Enter Your Email Here",
//                 ),
//               ),
//               TextField(
//                 controller: _password,
//                 obscureText: true,
//                 enableSuggestions: false,
//                 autocorrect: false,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: const InputDecoration(
//                   hintText: "Enter Your Password Here",
//                 ),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   final email = _email.text;
//                   final password = _password.text;
//                   //Handling Exception when Login fail or no user registered
//                   try {
//                     final userCredential = await FirebaseAuth.instance
//                         .signInWithEmailAndPassword(
//                             email: email, password: password);
//                     print(userCredential);
//                   } on FirebaseAuthException catch (e) {
//                     //print(e.code);
//                     if (e.code == 'user-not-found') {
//                       //print('user-not-found');
//                       // catch (e) {  //(e) catch all error
//                       //   print('Login Failed!');
//                       //   print(e); //print the error itself
//                       //   print(e.runtimeType); //print error type
//                     } else if (e.code == 'wrong-password') {
//                       print('Wrong Password!');
//                       // print('Something else happen');
//                       // print(e.code);
//                     }
//                   }
//                 },
//               child: const Text("Login"),
//               ),
//             ],
//           );
//         default:
//           return Text("Loading...");
//       }
//     },
//   ),
// );
//   }
// }
