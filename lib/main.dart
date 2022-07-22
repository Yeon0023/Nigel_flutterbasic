import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nigel_flutterbasic/view/Login_view.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //This is to connect device app to firebase server.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage()
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Home')),
    body: FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // print(user);
            // if (user?.emailVerified ?? false){
            //     return const Text('Done');
            //   } else {
            //     return const VerifyEmailView();
            //   }
            return const LoginView();
            default: 
              return const Text("Loading...");
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
          }
        },
      ),
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Please verify your email address:'),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          }, 
          child: const Text('Send email verification'),
        )
      ],
    );
  }
}

