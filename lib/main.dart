import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pattern/secondpage.dart';

import 'bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const MyHomePage(title: 'BLoC Pattern'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  changeThePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SecondPage()));
  }

  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Bloc(); //provides the object for the class
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                StreamBuilder<String>(
                  stream: bloc.email,
                  builder: (context, snapshot) => TextField(
                      onChanged: bloc.emailChanged,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: ('Email Address'),
                          labelText: ('Email Address'),
                          errorText: snapshot.error?.toString())),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<String>(
                  stream: bloc.password,
                  builder: (context, snapshot) => TextField(
                      onChanged: bloc.passwordChanged,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: ('Password'),
                          labelText: ('Password'),
                          errorText: snapshot.error?.toString())),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<bool>(
                  stream: bloc.submitCheck,
                  builder: (context, snapshot) => ElevatedButton(
                    onPressed: snapshot.hasData ? () => changeThePage(context) : null,
                    child: const Text('Submit'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
