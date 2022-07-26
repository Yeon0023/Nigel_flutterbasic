import 'package:flutter/material.dart';
import 'package:nigel_flutterbasic/Utilities/Show_error_dialog.dart';
import 'dart:developer' as devtools show log;
import 'package:nigel_flutterbasic/constats/routes.dart';
import 'package:nigel_flutterbasic/service/auth/auth_exception.dart';
import 'package:nigel_flutterbasic/service/auth/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
      ),
      body: Column(
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
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                await AuthService.firebase().sendEmailVerification();
                final user = AuthService.firebase().currentUser;
                //ignore: use_build_context_synchronously
                Navigator.of(context).pushNamed(verifyEmailRoute);
                //devtools.log(userCredential.toString());
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Weak Password!',
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  'Email already in use!',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  'This is an Invalid Email Address!',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Failed to register',
                );
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                //'/login/',
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!'),
          )
        ],
      ),
    );
  }
}












// ***This is old code****
// return Scaffold(
//       appBar: AppBar(title: const Text("Register")),
//       body: FutureBuilder(
//         future: Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform,
//         ),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               return Column(
//                 children: [
//                   TextField(
//                     controller: _email,
//                     enableSuggestions: false,
//                     autocorrect: false,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       hintText: "Enter Your Email Here",
//                     ),
//                   ),
//                   TextField(
//                     controller: _password,
//                     obscureText: true,
//                     enableSuggestions: false,
//                     autocorrect: false,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       hintText: "Enter Your Password Here",
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       final email = _email.text;
//                       final password = _password.text;
//                       try {
//                         final userCredential = await FirebaseAuth.instance
//                             .createUserWithEmailAndPassword(
//                                 email: email, password: password);
//                         print(userCredential);
//                       } on FirebaseAuthException catch (e) {
//                         if (e.code == 'weak-password') {
//                           print('Weak Password!');
//                         } else if (e.code == 'email-already-in-use') {
//                           print('Email already in use!');
//                         } else if (e.code == 'invalid-email') {
//                           print('Invalid Email!');
//                         }
//                       }
//                     },
//                     child: const Text("Register"),
//                   ),
//                 ],
//               );
//             default:
//               return Text("Loading...");
//           }
//         },
//       ),
//     );