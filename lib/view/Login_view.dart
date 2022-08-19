import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nigel_flutterbasic/constats/routes.dart';
import 'package:nigel_flutterbasic/service/auth/auth_exception.dart';
import 'package:nigel_flutterbasic/service/auth/auth_service.dart';
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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: const Text('login'),
        titleTextStyle: GoogleFonts.lobster(fontSize: 37),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 2,
                ),

                //User email key in box
                child: TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter Your Email Here',
                    hintStyle: TextStyle(),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5,
                ),
                //User Key in Password
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Enter Your Password Here",
                    hintStyle: TextStyle(fontSize: 16),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),

              //Login Button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  side: const BorderSide(color: Colors.black, width: 0.8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 145.5, vertical: 17),
                  textStyle: GoogleFonts.lobster(fontSize: 17),
                ),
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().logIn(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                      //If user email is verified
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
                  } on UserNotFoundAuthException {
                    await showErrorDialog(
                      context,
                      'User not found',
                    );
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                      context,
                      'Wrong Password',
                    );
                  } on GenericAuthException {
                    await showErrorDialog(
                      context,
                      'Authentication Error',
                    );
                  }
                },
                child: const Text("Sign In!"),
              ),

              // Register redirect button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: GoogleFonts.lobster(fontSize: 15),
                ),
                child: const Text('Not registered yet? Register here!'),
              )
            ],
          ),
        ),
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
