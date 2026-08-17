import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shabab_app/Views/HomeScreen.dart';
import 'package:shabab_app/providers/Todoprovider.dart';



void main() {
  runApp(
    // এখানে আমরা প্রোভাইডারকে উইজেট ট্রির একদম উপরে বসাচ্ছি
    ChangeNotifierProvider(
      create: (context) => Todoprovider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen() ,
    );
  }
}


